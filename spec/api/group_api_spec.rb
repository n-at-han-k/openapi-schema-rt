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

RSpec.describe "GroupApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/group/{id}" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}", "id")

    delete "DELETE /group/{id}" do
      operationId "group_id_delete"
      tags "Group"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:group) }
        run_test!
      end
    end

    get "GET /group/{id}" do
      operationId "group_id_get"
      tags "Group"

      response 200, "Group info fetched successfully." do
        schema RT.response_schema("/group/{id}", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end

    put "PUT /group/{id}" do
      operationId "group_id_put"
      tags "Group"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/group/{id}", "put") }
      }

      response 200, "This is returned pretty much always. You need to inspect the content to figure out what happened." do
        schema RT.response_schema("/group/{id}", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:group) }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/group" do

    post "POST /group" do
      operationId "group_post"
      tags "Group"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/group", "post") }
      }

      response 201, "Group created successfully." do
        schema RT.response_schema("/group", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/groups" do

    post "POST /groups" do
      operationId "groups_post"
      tags "Group"
      request_body required: false, content: {
        "application/json" => { schema: RT.body_schema("/groups", "post") }
      }

      response 200, "No errors" do
        schema RT.response_schema("/groups", "post", "200")
        let(:query) { 'query_example' }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

end
