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

RSpec.describe "MiscellaneousApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/rt" do

    get "GET /rt" do
      operationId "rt_get"
      tags "Miscellaneous"

      response 200, "Success" do
        schema RT.response_schema("/rt", "get", "200")
        run_test!
      end
    end
  end

end
