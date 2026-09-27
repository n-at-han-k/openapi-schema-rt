package rtrspec;

import org.openapitools.codegen.CodegenModel;
import org.openapitools.codegen.CodegenOperation;
import org.openapitools.codegen.CodegenParameter;
import org.openapitools.codegen.CodegenProperty;
import org.openapitools.codegen.languages.RubyClientCodegen;
import org.openapitools.codegen.model.ModelMap;
import org.openapitools.codegen.model.OperationsMap;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

/**
 * A conformance suite, from the document, for a live RT.
 *
 * The suite that came before this was a template plus a hand-written
 * fixtures.yml: one file saying which id to read and what body to send, per
 * endpoint, maintained by whoever last got a 400. That is the document's job.
 * Everything per-endpoint is decided HERE, from what the document says, and
 * written into the generated spec; spec_helper.rb is left with only the parts
 * that are the same for every endpoint -- make the request, check the status,
 * validate the body.
 *
 * Three things have to be decided per operation, and all three are readable
 * from the document:
 *
 * <ul>
 * <li><b>Does it change anything.</b> A PUT, a PATCH or a DELETE does; a POST
 *     does when the document says it answers 201, which is what tells RT's
 *     creates apart from its searches.</li>
 * <li><b>What to aim it at.</b> A read uses the parameter's own {@code
 *     example}. A write must not: the example for {@code idOrName} is
 *     `General`, and a suite that deletes queue General is a suite you run
 *     once. A write is aimed at a SCRATCH object of the kind the path names,
 *     which the runner makes and removes.</li>
 * <li><b>What to send.</b> The request schema's required fields, with the
 *     document's example for each where there is one and a value of the right
 *     type where there is not. A field that names another object -- Queue,
 *     Catalog, Class -- gets a scratch one of those, because a create has to
 *     point at something that exists.</li>
 * </ul>
 */
public class RspecCodegen extends RubyClientCodegen {

    /** Objects the runner can make on demand; see spec/scratch.rb. */
    private static final Set<String> SCRATCH = Set.of(
            "queue", "group", "user", "catalog", "class", "customfield",
            "lifecycle", "ticket", "asset", "article");

    /** A body field that has to name one of those, rather than be invented. */
    private static final Map<String, String> REFERENCES = Map.of(
            "Queue", "queue",
            "Catalog", "catalog",
            "Class", "class",
            "Group", "group",
            "User", "user",
            "Owner", "user",
            "ObjectId", "queue");

    @Override
    public String getName() {
        return "rt-rspec";
    }

    @Override
    public String getHelp() {
        return "Generates an RSpec conformance suite for a live RT from this document.";
    }

    @Override
    public void processOpts() {
        super.processOpts();

        // Only the specs. The client, the models and the gem scaffolding are
        // all things that could be wrong about the API in their own right.
        templateDir = "rspec";
        embeddedTemplateDir = "rspec";
        apiTemplateFiles.clear();
        modelTemplateFiles.clear();
        modelTestTemplateFiles.clear();
        modelDocTemplateFiles.clear();
        apiDocTemplateFiles.clear();
        supportingFiles.clear();
        apiTestTemplateFiles.clear();
        apiTestTemplateFiles.put("api_test.mustache", ".rb");
    }

    /**
     * What has to exist before an operation is worth calling, from the
     * document's own {@code links}.
     *
     * Revoking a right RT never granted answers 500, so the revoke examples
     * would test RT's error handling instead of the operation. The document
     * says which grant undoes to which revoke -- that is what the links on
     * every `POST .../rights` are for -- so reading them backwards gives the
     * request to make first, without the runner knowing that rights exist.
     */
    private final Map<String, String> setupFor = new LinkedHashMap<>();

    @Override
    public void preprocessOpenAPI(io.swagger.v3.oas.models.OpenAPI openAPI) {
        super.preprocessOpenAPI(openAPI);

        if (openAPI.getPaths() == null) {
            return;
        }

        openAPI.getPaths().forEach((path, item) -> item.readOperationsMap().forEach((verb, operation) -> {
            if (operation.getResponses() == null) {
                return;
            }

            operation.getResponses().forEach((code, response) -> {
                if (response.getLinks() == null) {
                    return;
                }

                response.getLinks().forEach((name, link) -> {
                    if (link.getOperationId() == null) {
                        return;
                    }

                    // The source operation, spelled as Ruby for the runner to
                    // make before the target one.
                    setupFor.put(link.getOperationId(), verb.name() + "|" + path);
                });
            });
        }));
    }

    @Override
    public OperationsMap postProcessOperationsWithModels(OperationsMap objs, List<ModelMap> allModels) {
        OperationsMap processed = super.postProcessOperationsWithModels(objs, allModels);

        // openapi-ruby declares operations inside ONE `path` block per path, so
        // the operations are regrouped here: openapi-generator hands them over
        // grouped by tag, in whatever order it read them.
        Map<String, List<Map<String, Object>>> byPath = new LinkedHashMap<>();
        Map<String, List<Map<String, Object>>> paramsByPath = new LinkedHashMap<>();

        for (CodegenOperation op : processed.getOperations().getOperation()) {
            String method = op.httpMethod.toUpperCase(Locale.ROOT);
            // Every POST this document describes is a write. It used to
            // need "and answers 201" to tell RT's creates from its searches,
            // which POST too -- but the searches are not described here, and
            // the ones that remain all change something: a grant, a bulk
            // grant, an application of a custom field.
            boolean mutating = method.equals("PUT") || method.equals("PATCH")
                    || method.equals("DELETE") || method.equals("POST");

            Map<String, Object> declared = new LinkedHashMap<>();
            declared.put("verb", method.toLowerCase(Locale.ROOT));
            declared.put("summary", op.summary != null && !op.summary.isEmpty()
                    ? op.summary.replace("\"", "'")
                    : method + " " + op.path);
            declared.put("operationId", op.operationId);
            declared.put("tags", op.tags == null ? List.of()
                    : op.tags.stream().map(tag -> tag.getName()).toList());
            declared.put("hasBody", op.bodyParam != null);
            declared.put("bodyRequired", op.bodyParam != null && op.bodyParam.required);
            declared.put("path", op.path);
            declared.put("checked", List.of(checked(op, allModels, mutating)));

            byPath.computeIfAbsent(op.path, key -> new ArrayList<>()).add(declared);

            // The path's own parameters, declared once above its operations.
            List<Map<String, Object>> shared =
                    paramsByPath.computeIfAbsent(op.path, key -> new ArrayList<>());
            if (op.pathParams != null) {
                for (CodegenParameter param : op.pathParams) {
                    boolean seen = shared.stream()
                            .anyMatch(entry -> param.baseName.equals(entry.get("baseName")));
                    if (seen) {
                        continue;
                    }

                    Map<String, Object> entry = new LinkedHashMap<>();
                    entry.put("baseName", param.baseName);
                    entry.put("paramName", param.paramName);
                    entry.put("path", op.path);
                    shared.add(entry);
                }
            }
        }

        List<Map<String, Object>> paths = new ArrayList<>();
        byPath.forEach((path, operations) -> {
            Map<String, Object> entry = new LinkedHashMap<>();
            entry.put("path", path);
            entry.put("parameters", paramsByPath.getOrDefault(path, List.of()));
            entry.put("operations", operations);
            paths.add(entry);
        });

        processed.getOperations().put("paths", paths);

        return processed;
    }

    /**
     * The one response this suite exercises, and everything the example needs
     * to provoke it.
     *
     * The success response: an operation has one, and the failures are
     * documented for the sake of the document rather than to be provoked --
     * making RT answer its own 400 means sending a request the document says
     * is invalid, which openapi-ruby validates and refuses before it is sent.
     */
    private Map<String, Object> checked(CodegenOperation op, List<ModelMap> allModels, boolean mutating) {
        Map<String, Object> checked = new LinkedHashMap<>();

        String code = success(op);
        checked.put("code", code);
        checked.put("description", description(op, code));
        checked.put("hasSchema", hasSchema(op, code));
        checked.put("mutating", mutating);

        List<Map<String, Object>> params = new ArrayList<>();
        if (op.pathParams != null) {
            for (CodegenParameter param : op.pathParams) {
                Map<String, Object> entry = new LinkedHashMap<>();
                entry.put("name", param.baseName);
                entry.put("value", mutating
                        ? scratchFor(op.path, param.baseName)
                        : literal(example(param)));
                params.add(entry);
            }
        }
        if (op.queryParams != null) {
            for (CodegenParameter param : op.queryParams) {
                Object value = example(param);
                if (value == null) {
                    continue;
                }
                Map<String, Object> entry = new LinkedHashMap<>();
                entry.put("name", param.baseName);
                entry.put("value", literal(value));
                params.add(entry);
            }
        }
        checked.put("params", params);

        String body = op.bodyParam == null ? null : body(op, allModels);
        checked.put("hasBody", body != null);
        checked.put("body", body);

        // A delete removes the scratch object it was aimed at, and the next
        // example that wants one of those must make a new one rather than
        // reuse the id of something RT has just disabled.
        boolean removes = "DELETE".equals(op.httpMethod.toUpperCase(Locale.ROOT));
        checked.put("forgets", removes ? subjectOf(op.path) : null);
        checked.put("hasForget", removes && SCRATCH.contains(subjectOf(op.path)));

        String setup = setupFor.get(op.operationId);

        // A link says one operation leads to another, which is not the same as
        // being its precondition: upstream links a queue's create to its
        // delete, and the delete needs no help. What a revoke needs is the
        // GRANT, and the grant's path is a prefix of the revoke's -- that is
        // the shape worth acting on.
        if (setup != null
                && (!"DELETE".equals(op.httpMethod.toUpperCase(Locale.ROOT))
                    || !op.path.startsWith(setup.split("\\|")[1] + "/"))) {
            setup = null;
        }

        checked.put("hasSetup", setup != null);
        if (setup != null) {
            checked.put("setupMethod", setup.split("\\|")[0]);
            checked.put("setupPath", setup.split("\\|")[1]);
            checked.put("setupParams", setupParams(op));
        }

        return checked;
    }

    /** The parameters a setup request shares with the operation it precedes. */
    private String setupParams(CodegenOperation op) {
        List<String> entries = new ArrayList<>();

        if (op.pathParams != null) {
            for (CodegenParameter param : op.pathParams) {
                entries.add("'" + param.baseName + "' => " + param.paramName);
            }
        }

        return "{ " + String.join(", ", entries) + " }";
    }

    private String success(CodegenOperation op) {
        if (op.responses != null) {
            for (String wanted : List.of("200", "201", "204")) {
                if (answers(op, wanted)) {
                    return wanted;
                }
            }
        }

        return "200";
    }

    private String description(CodegenOperation op, String code) {
        if (op.responses != null) {
            for (var response : op.responses) {
                if (code.equals(response.code) && response.message != null) {
                    return response.message.replace("\"", "'").lines().findFirst().orElse(code);
                }
            }
        }

        return "answers " + code;
    }

    private boolean hasSchema(CodegenOperation op, String code) {
        if (op.responses == null) {
            return false;
        }

        for (var response : op.responses) {
            if (code.equals(response.code)) {
                return response.dataType != null && !response.dataType.isEmpty();
            }
        }

        return false;
    }

    private boolean answers(CodegenOperation op, String code) {
        return op.responses != null
                && op.responses.stream().anyMatch(response -> code.equals(response.code));
    }

    /**
     * Ruby source for the path parameters: an example to read, a scratch
     * object to write to.
     */
    private String params(CodegenOperation op, boolean mutating) {
        if (op.pathParams == null || op.pathParams.isEmpty()) {
            return "{}";
        }

        List<String> entries = new ArrayList<>();

        for (CodegenParameter param : op.pathParams) {
            entries.add("'" + param.baseName + "' => " + (mutating
                    ? scratchFor(op.path, param.baseName)
                    : literal(example(param))));
        }

        return "{ " + String.join(", ", entries) + " }";
    }

    /**
     * Which scratch object a path parameter addresses. The path says so: the
     * first literal segment names the kind, and the parameters that are not
     * that kind are the ones RT spells out -- a principal, a value, an object
     * a custom field is applied to.
     */
    private String scratchFor(String path, String name) {
        switch (name) {
            case "valueId":
                return ":scratch_value";
            case "principalId":
                // `.../rights/{right}/user/{principalId}` wants a user, and
                // the otherwise identical `/group/` one wants a group.
                return path.contains("/user/{principalId}") ? "scratch(:user)" : "scratch(:group)";
            case "groupId":
                return "scratch(:group)";
            case "objectId":
                return "scratch(:queue)";
            case "right":
                return "'SeeQueue'";
            default:
                break;
        }

        String subject = subjectOf(path);

        return SCRATCH.contains(subject) ? "scratch(:" + subject + ")" : "nil";
    }

    private String subjectOf(String path) {
        for (String segment : path.split("/")) {
            if (segment.isEmpty() || segment.startsWith("{")) {
                continue;
            }

            String singular = segment.endsWith("s") && !segment.endsWith("ss")
                    ? segment.substring(0, segment.length() - 1)
                    : segment;

            return SCRATCH.contains(singular) ? singular : segment;
        }

        return "";
    }

    /** The query string a read needs, from its query parameters' examples. */
    private String query(CodegenOperation op) {
        if (op.queryParams == null || op.queryParams.isEmpty()) {
            return "nil";
        }

        List<String> pairs = new ArrayList<>();

        for (CodegenParameter param : op.queryParams) {
            Object value = example(param);
            if (value != null) {
                pairs.add(param.baseName + "=" + value);
            }
        }

        return pairs.isEmpty() ? "nil" : literal(String.join("&", pairs));
    }

    /**
     * Ruby source for the request body: the schema's required fields, the
     * document's example for each where it has one.
     */
    private String body(CodegenOperation op, List<ModelMap> allModels) {
        if (op.bodyParam == null) {
            return "nil";
        }

        // A body the document gives an example for is used verbatim: it is
        // the document's own answer to "what does a request look like".
        if (op.bodyParam.example != null && !op.bodyParam.example.isEmpty()) {
            // The document's own example, with the objects it names swapped
            // for scratch ones. `Group: Everyone` is the right thing for a
            // document to say and the wrong thing for a suite to do twice --
            // RT answers 400 to granting a right a principal already has.
            String references = REFERENCES.entrySet().stream()
                    .map(entry -> "'" + entry.getKey() + "' => :" + entry.getValue())
                    .reduce((a, b) -> a + ", " + b)
                    .orElse("");

            return "RT.with_scratch(JSON.parse(" + literal(op.bodyParam.example)
                    + "), { " + references + " })";
        }

        CodegenModel model = modelFor(op.bodyParam, allModels);


        if (model == null) {
            return op.bodyParam.isArray ? "[]" : "{}";
        }

        List<String> entries = new ArrayList<>();
        List<CodegenProperty> properties =
                model.allVars != null && !model.allVars.isEmpty() ? model.allVars : model.vars;

        boolean named = false;

        for (CodegenProperty property : properties) {
            boolean reference = REFERENCES.containsKey(property.baseName);

            // Required, or the thing the request is ABOUT. A grant declares
            // only `Right` required, because the principal may be spelled
            // either Group or User -- and a grant to neither is a 400. The
            // first reference field is sent; the second would name a second
            // principal.
            if (!property.required && !(reference && !named)) {
                continue;
            }

            if (reference && !property.required) {
                named = true;
            }

            entries.add("'" + property.baseName + "' => " + value(property));
        }

        // Nothing the schema marks required: send the smallest thing that is
        // still a change, which is the first scalar it offers -- valued the
        // same way as any other field, so a Name is still unique.
        if (entries.isEmpty()) {
            for (CodegenProperty property : properties) {
                if (property.isString && !REFERENCES.containsKey(property.baseName)) {
                    entries.add("'" + property.baseName + "' => " + value(property));
                    break;
                }
            }
        }

        return "{ " + String.join(", ", entries) + " }";
    }

    private CodegenModel modelFor(CodegenParameter body, List<ModelMap> allModels) {
        String wanted = body.baseType != null ? body.baseType : body.dataType;

        for (ModelMap map : allModels) {
            if (map.getModel().classname.equals(wanted)) {
                return map.getModel();
            }
        }

        return null;
    }

    /** A value of the right kind for one field. */
    private String value(CodegenProperty property) {
        String reference = REFERENCES.get(property.baseName);
        if (reference != null) {
            // Not invented: a create has to point at something that is there,
            // and pointing it at a real queue would be writing to real data.
            return "ObjectId".equals(property.baseName)
                    ? "Integer(scratch(:" + reference + "))"
                    : "scratch(:" + reference + ")";
        }

        // Before the example, not after it: the document's example for a
        // Name is a good name and a TAKEN one by the second run. RT refuses a
        // name it already has, and its deletes only disable, so the name is
        // never free again.
        if ("Name".equals(property.baseName) || "Subject".equals(property.baseName)) {
            return "unique('conf')";
        }
        if (property._enum != null && !property._enum.isEmpty()) {
            return literal(String.valueOf(property._enum.get(0)));
        }
        if (property.example != null && !property.example.isEmpty()) {
            return literal(property.example);
        }
        if (property.isInteger || property.isLong || property.isNumber) {
            return "1";
        }
        if (property.isBoolean) {
            return "true";
        }
        if (property.isArray) {
            return "[]";
        }
        if (property.isMap || property.isModel) {
            return "{}";
        }

        return "'conformance suite'";
    }

    private Object example(CodegenParameter param) {
        // `example` on the parameter, or on its schema -- openapi-generator
        // copies the schema's up onto the parameter, so one field answers
        // both spellings the document may use.
        if (param.example != null && !param.example.isEmpty()) {
            return param.example;
        }

        return null;
    }

    /** A Ruby single-quoted string, or nil. */
    private String literal(Object value) {
        if (value == null) {
            return "nil";
        }

        return "'" + String.valueOf(value).replace("\\", "\\\\").replace("'", "\\'") + "'";
    }

    /** The map the template iterates, so a missing value is visible as nil. */
    @SuppressWarnings("unused")
    private Map<String, Object> pair(String key, Object value) {
        Map<String, Object> entry = new LinkedHashMap<>();
        entry.put("key", key);
        entry.put("value", value);

        return entry;
    }
}
