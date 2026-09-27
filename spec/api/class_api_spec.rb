# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# openapi-ruby's DSL: each operation is DECLARED as the document describes it,
# and run_test! makes the request against a real RT and validates what comes
# back against that declaration. The declaration IS the document -- the schemas
# are the document's own components -- so nothing here restates a schema and
# nothing can drift from one.
#
# What each example needs (which object to aim it at, what to send, what has to
# exist first) was worked out from the document by
# generators/rspec/src/rtrspec/RspecCodegen.java. spec/openapi_helper.rb knows
# nothing about any endpoint.

require "openapi_helper"

RSpec.describe "ClassApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/class/{idOrName}" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/class/{idOrName}", "idOrName")

    delete "DELETE /class/{idOrName}" do
      operationId "class_id_name_delete"
      tags "Class"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:class) }
        # What this removed is gone: the next example that needs one makes it.
        after { RT::Scratch.forget("class") }
        run_test!
      end
    end

    get "GET /class/{idOrName}" do
      operationId "class_id_name_get"
      tags "Class"

      response 200, "Class queried successfully." do
        schema RT.response_schema("/class/{idOrName}", "get", "200")
        let(:idOrName) { 'General' }
        run_test!
      end
    end

    put "PUT /class/{idOrName}" do
      operationId "class_id_name_put"
      tags "Class"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/class/{idOrName}", "put") }
      }

      response 200, "This is returned pretty much always. You need to inspect the content to figure out what happened." do
        schema RT.response_schema("/class/{idOrName}", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:class) }
        let(:request_body) { { 'Name' => unique('conf') } }
        run_test!
      end
    end
  end

  path "/class" do

    post "POST /class" do
      operationId "class_post"
      tags "Class"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/class", "post") }
      }

      response 201, "Class created successfully." do
        schema RT.response_schema("/class", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:request_body) { RT.with_scratch(JSON.parse('{"Name":"Runbooks"}'), { 'Owner' => :user, 'Class' => :class, 'Group' => :group, 'Catalog' => :catalog, 'ObjectId' => :queue, 'User' => :user, 'Queue' => :queue }) }
        run_test!
      end
    end
  end

  path "/classes/all" do

    get "GET /classes/all" do
      operationId "classes_all_get"
      tags "Class"

      response 200, "Classes queried successfully." do
        schema RT.response_schema("/classes/all", "get", "200")
        run_test!
      end
    end
  end

end
