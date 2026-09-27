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

RSpec.describe "AssetApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/asset/{id}" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/asset/{id}", "id")

    get "GET /asset/{id}" do
      operationId "asset_id_get"
      tags "Asset"

      response 200, "Asset queried successfully." do
        schema RT.response_schema("/asset/{id}", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end

    put "PUT /asset/{id}" do
      operationId "asset_id_put"
      tags "Asset"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/asset/{id}", "put") }
      }

      response 200, "This is returned pretty much always. You need to inspect the content to figure out what happened." do
        schema RT.response_schema("/asset/{id}", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:asset) }
        let(:request_body) { { 'Catalog' => scratch(:catalog) } }
        run_test!
      end
    end
  end

  path "/asset" do

    post "POST /asset" do
      operationId "asset_post"
      tags "Asset"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/asset", "post") }
      }

      response 201, "Asset created successfully." do
        schema RT.response_schema("/asset", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:request_body) { RT.with_scratch(JSON.parse('{"Name":"nathans-laptop","Catalog":"Laptops","Status":"in-use"}'), { 'Owner' => :user, 'Class' => :class, 'Group' => :group, 'Catalog' => :catalog, 'ObjectId' => :queue, 'User' => :user, 'Queue' => :queue }) }
        run_test!
      end
    end
  end

end
