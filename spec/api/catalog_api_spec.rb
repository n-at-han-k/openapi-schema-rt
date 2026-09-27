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

RSpec.describe "CatalogApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/catalog/{idOrName}" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/catalog/{idOrName}", "idOrName")

    delete "DELETE /catalog/{idOrName}" do
      operationId "catalog_id_name_delete"
      tags "Catalog"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:catalog) }
        run_test!
      end
    end

    get "GET /catalog/{idOrName}" do
      operationId "catalog_id_name_get"
      tags "Catalog"

      response 200, "Catalog queried successfully." do
        schema RT.response_schema("/catalog/{idOrName}", "get", "200")
        let(:idOrName) { 'General' }
        run_test!
      end
    end

    put "PUT /catalog/{idOrName}" do
      operationId "catalog_id_name_put"
      tags "Catalog"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/catalog/{idOrName}", "put") }
      }

      response 200, "This is returned pretty much always. You need to inspect the content to figure out what happened." do
        schema RT.response_schema("/catalog/{idOrName}", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:catalog) }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/catalog" do

    post "POST /catalog" do
      operationId "catalog_post"
      tags "Catalog"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/catalog", "post") }
      }

      response 201, "Catalog created successfully." do
        schema RT.response_schema("/catalog", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:request_body) { JSON.parse('{"Name":"Laptops","Lifecycle":"assets"}') }
        run_test!
      end
    end
  end

  path "/catalogs/all" do

    get "GET /catalogs/all" do
      operationId "catalogs_all_get"
      tags "Catalog"

      response 200, "Catalogs queried successfully." do
        schema RT.response_schema("/catalogs/all", "get", "200")
        run_test!
      end
    end
  end

end
