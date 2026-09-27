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

RSpec.describe "CustomFieldApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/catalog/{id}/customfields" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/catalog/{id}/customfields", "id")

    get "GET /catalog/{id}/customfields" do
      operationId "catalog_id_customfields_get"
      tags "Custom Field"

      response 200, "Custom fields queried successfully." do
        schema RT.response_schema("/catalog/{id}/customfields", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end
  end

  path "/class/{id}/customfields" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/class/{id}/customfields", "id")

    get "GET /class/{id}/customfields" do
      operationId "class_id_customfields_get"
      tags "Custom Field"

      response 200, "Custom fields queried successfully." do
        schema RT.response_schema("/class/{id}/customfields", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end
  end

  path "/customfield/{id}/appliesto" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/appliesto", "id")

    get "GET /customfield/{id}/appliesto" do
      operationId "customfield_id_appliesto_get"
      tags "Custom Field"

      response 200, "Applications queried successfully." do
        schema RT.response_schema("/customfield/{id}/appliesto", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end

    post "POST /customfield/{id}/appliesto" do
      operationId "customfield_id_appliesto_post"
      tags "Custom Field"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/customfield/{id}/appliesto", "post") }
      }

      response 201, "Applied successfully." do
        schema RT.response_schema("/customfield/{id}/appliesto", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:customfield) }
        let(:request_body) { JSON.parse('{"ObjectId":1}') }
        run_test!
      end
    end
  end

  path "/customfield/{id}/appliesto/object/{objectId}" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/appliesto/object/{objectId}", "id")
    parameter name: :objectId, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/appliesto/object/{objectId}", "objectId")

    delete "DELETE /customfield/{id}/appliesto/object/{objectId}" do
      operationId "customfield_id_appliesto_object_delete"
      tags "Custom Field"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:customfield) }
        let(:objectId) { scratch(:queue) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/customfield/{id}/appliesto", { 'id' => id, 'objectId' => object_id }) }
        run_test!
      end
    end
  end

  path "/customfield/{id}" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}", "id")

    delete "DELETE /customfield/{id}" do
      operationId "customfield_id_delete"
      tags "Custom Field"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:customfield) }
        run_test!
      end
    end

    get "GET /customfield/{id}" do
      operationId "customfield_id_get"
      tags "Custom Field"

      response 200, "Successfully fetched custom field info." do
        schema RT.response_schema("/customfield/{id}", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end

    put "PUT /customfield/{id}" do
      operationId "customfield_id_put"
      tags "Custom Field"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/customfield/{id}", "put") }
      }

      response 200, "This is returned pretty much always. You need to inspect the content to figure out what happened." do
        schema RT.response_schema("/customfield/{id}", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:customfield) }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/customfield/{id}/value/{valueId}" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/value/{valueId}", "id")
    parameter name: :valueId, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/value/{valueId}", "valueId")

    delete "DELETE /customfield/{id}/value/{valueId}" do
      operationId "customfield_id_value_id_delete"
      tags "Custom Field"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:customfield) }
        let(:valueId) { :scratch_value }
        run_test!
      end
    end

    get "GET /customfield/{id}/value/{valueId}" do
      operationId "customfield_id_value_id_get"
      tags "Custom Field"

      response 200, "Value queried successfully." do
        schema RT.response_schema("/customfield/{id}/value/{valueId}", "get", "200")
        let(:id) { '1' }
        let(:valueId) { '56' }
        run_test!
      end
    end

    put "PUT /customfield/{id}/value/{valueId}" do
      operationId "customfield_id_value_id_put"
      tags "Custom Field"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/customfield/{id}/value/{valueId}", "put") }
      }

      response 200, "This is returned pretty much always. You need to inspect the content to figure out what happened." do
        schema RT.response_schema("/customfield/{id}/value/{valueId}", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:customfield) }
        let(:valueId) { :scratch_value }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/customfield/{id}/value" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/value", "id")

    post "POST /customfield/{id}/value" do
      operationId "customfield_id_value_post"
      tags "Custom Field"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/customfield/{id}/value", "post") }
      }

      response 201, "Value created successfully." do
        schema RT.response_schema("/customfield/{id}/value", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:customfield) }
        let(:request_body) { JSON.parse('{"Name":"High","SortOrder":"1"}') }
        run_test!
      end
    end
  end

  path "/customfield/{id}/values" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/values", "id")

    get "GET /customfield/{id}/values" do
      operationId "customfield_id_values_get"
      tags "Custom Field"

      response 200, "Values queried successfully." do
        schema RT.response_schema("/customfield/{id}/values", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end
  end

  path "/customfield" do

    post "POST /customfield" do
      operationId "customfield_post"
      tags "Custom Field"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/customfield", "post") }
      }

      response 201, "Ticket created successfully." do
        schema RT.response_schema("/customfield", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:request_body) { JSON.parse('{"Name":"Delivery Date","Type":"Date","MaxValues":"1","LookupType":"RT::Queue-RT::Ticket"}') }
        run_test!
      end
    end
  end

  path "/customfields" do

    post "POST /customfields" do
      operationId "customfields_post"
      tags "Custom Field"
      request_body required: false, content: {
        "application/json" => { schema: RT.body_schema("/customfields", "post") }
      }

      response 200, "No errors" do
        schema RT.response_schema("/customfields", "post", "200")
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/queue/{id}/customfields" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/queue/{id}/customfields", "id")

    get "GET /queue/{id}/customfields" do
      operationId "queue_id_customfields_get"
      tags "Custom Field"

      response 200, "Custom fields queried successfully." do
        schema RT.response_schema("/queue/{id}/customfields", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end
  end

end
