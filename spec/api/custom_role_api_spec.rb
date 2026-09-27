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

RSpec.describe "CustomRoleApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/customrole/{id}" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/customrole/{id}", "id")

    get "GET /customrole/{id}" do
      operationId "customrole_id_get"
      tags "Custom Role"

      response 200, "Custom role queried successfully." do
        schema RT.response_schema("/customrole/{id}", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end
  end

  path "/customroles" do

    post "POST /customroles" do
      operationId "customroles_get"
      tags "Custom Role"
      request_body required: false, content: {
        "application/json" => { schema: RT.body_schema("/customroles", "post") }
      }

      response 200, "Custom roles queried successfully." do
        schema RT.response_schema("/customroles", "post", "200")
        let(:request_body) { {} }
        run_test!
      end
    end
  end

end
