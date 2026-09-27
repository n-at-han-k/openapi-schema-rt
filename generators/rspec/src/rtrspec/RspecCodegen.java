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
                    setupFor.put(link.getOperationId(),
                            "{ method: '" + verb.name() + "', path: '" + path + "' }");
                });
            });
        }));
    }

    @Override
    public OperationsMap postProcessOperationsWithModels(OperationsMap objs, List<ModelMap> allModels) {
        OperationsMap processed = super.postProcessOperationsWithModels(objs, allModels);

        for (CodegenOperation op : processed.getOperations().getOperation()) {
            String method = op.httpMethod.toUpperCase(Locale.ROOT);
            boolean mutating = method.equals("PUT") || method.equals("PATCH")
                    || method.equals("DELETE")
                    || (method.equals("POST") && answers(op, "201"));

            op.vendorExtensions.put("x-mutating", mutating);
            op.vendorExtensions.put("x-params", params(op, mutating));
            op.vendorExtensions.put("x-query", query(op));
            op.vendorExtensions.put("x-body", body(op, allModels));
            op.vendorExtensions.put("x-setup", setupFor.getOrDefault(op.operationId, "nil"));
        }

        return processed;
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
            return "JSON.parse(" + literal(op.bodyParam.example) + ")";
        }

        CodegenModel model = modelFor(op.bodyParam, allModels);

        if (model == null) {
            return op.bodyParam.isArray ? "[]" : "{}";
        }

        List<String> entries = new ArrayList<>();
        List<CodegenProperty> properties =
                model.allVars != null && !model.allVars.isEmpty() ? model.allVars : model.vars;

        for (CodegenProperty property : properties) {
            if (!property.required) {
                continue;
            }

            entries.add("'" + property.baseName + "' => " + value(property));
        }

        // Nothing required: send the smallest thing that is still a change,
        // which is the first optional scalar the schema offers.
        if (entries.isEmpty()) {
            for (CodegenProperty property : properties) {
                if (property.isString && !REFERENCES.containsKey(property.baseName)) {
                    entries.add("'" + property.baseName + "' => 'conformance suite'");
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

        if (property._enum != null && !property._enum.isEmpty()) {
            return literal(String.valueOf(property._enum.get(0)));
        }
        if (property.example != null && !property.example.isEmpty()) {
            return literal(property.example);
        }
        if ("Name".equals(property.baseName) || "Subject".equals(property.baseName)) {
            // Unique, because RT refuses a name it already has and its
            // deletes only disable.
            return "unique('conf')";
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
