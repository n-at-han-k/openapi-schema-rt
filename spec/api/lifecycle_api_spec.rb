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

RSpec.describe "LifecycleApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/lifecycle/{name}" do
    parameter name: :name, in: :path, required: true,
              schema: RT.parameter_schema("/lifecycle/{name}", "name")

    delete "DELETE /lifecycle/{name}" do
      operationId "lifecycle_name_delete"
      tags "Lifecycle"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:name) { scratch(:lifecycle) }
        # What this removed is gone: the next example that needs one makes it.
        after { RT::Scratch.forget("lifecycle") }
        run_test!
      end
    end

    get "GET /lifecycle/{name}" do
      operationId "lifecycle_name_get"
      tags "Lifecycle"

      response 200, "Lifecycle queried successfully." do
        schema RT.response_schema("/lifecycle/{name}", "get", "200")
        let(:name) { 'default' }
        run_test!
      end
    end

    put "PUT /lifecycle/{name}" do
      operationId "lifecycle_name_put"
      tags "Lifecycle"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/lifecycle/{name}", "put") }
      }

      response 200, "Lifecycle updated." do
        schema RT.response_schema("/lifecycle/{name}", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:name) { scratch(:lifecycle) }
        let(:request_body) { { 'type' => 'ticket' } }
        run_test!
      end
    end
  end

  path "/lifecycle/{name}/maps" do
    parameter name: :name, in: :path, required: true,
              schema: RT.parameter_schema("/lifecycle/{name}/maps", "name")

    get "GET /lifecycle/{name}/maps" do
      operationId "lifecycle_name_maps_get"
      tags "Lifecycle"

      response 200, "Maps queried successfully." do
        schema RT.response_schema("/lifecycle/{name}/maps", "get", "200")
        let(:name) { 'default' }
        run_test!
      end
    end

    put "PUT /lifecycle/{name}/maps" do
      operationId "lifecycle_name_maps_put"
      tags "Lifecycle"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/lifecycle/{name}/maps", "put") }
      }

      response 200, "Maps updated." do
        schema RT.response_schema("/lifecycle/{name}/maps", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:name) { scratch(:lifecycle) }
        let(:request_body) { RT.with_scratch(JSON.parse('Object'), { 'Owner' => :user, 'Class' => :class, 'Group' => :group, 'Catalog' => :catalog, 'ObjectId' => :queue, 'User' => :user, 'Queue' => :queue }) }
        run_test!
      end
    end
  end

  path "/lifecycle/{name}/validate" do
    parameter name: :name, in: :path, required: true,
              schema: RT.parameter_schema("/lifecycle/{name}/validate", "name")

    post "POST /lifecycle/{name}/validate" do
      operationId "lifecycle_name_validate_post"
      tags "Lifecycle"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/lifecycle/{name}/validate", "post") }
      }

      response 200, "The configuration was checked." do
        schema RT.response_schema("/lifecycle/{name}/validate", "post", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:name) { scratch(:lifecycle) }
        let(:request_body) { { 'type' => 'ticket' } }
        run_test!
      end
    end
  end

  path "/lifecycles" do

    get "GET /lifecycles" do
      operationId "lifecycles_get"
      tags "Lifecycle"

      response 200, "Lifecycles queried successfully." do
        schema RT.response_schema("/lifecycles", "get", "200")
        let(:type) { 'type_example' }
        run_test!
      end
    end

    post "POST /lifecycles" do
      operationId "lifecycles_post"
      tags "Lifecycle"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/lifecycles", "post") }
      }

      response 201, "Lifecycle created successfully." do
        schema RT.response_schema("/lifecycles", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:request_body) { { 'Name' => unique('conf'), 'Type' => 'ticket' } }
        run_test!
      end
    end
  end

end
