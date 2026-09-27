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

RSpec.describe "ArticleApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/article/{id}" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/article/{id}", "id")

    delete "DELETE /article/{id}" do
      operationId "article_id_delete"
      tags "Article"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:article) }
        run_test!
      end
    end

    get "GET /article/{id}" do
      operationId "article_id_get"
      tags "Article"

      response 200, "Article queried successfully." do
        schema RT.response_schema("/article/{id}", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end

    put "PUT /article/{id}" do
      operationId "article_id_put"
      tags "Article"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/article/{id}", "put") }
      }

      response 200, "This is returned pretty much always. You need to inspect the content to figure out what happened." do
        schema RT.response_schema("/article/{id}", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:article) }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/article" do

    post "POST /article" do
      operationId "article_post"
      tags "Article"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/article", "post") }
      }

      response 201, "Article created successfully." do
        schema RT.response_schema("/article", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:request_body) { JSON.parse('{"Name":"How to restart the widget service","Class":"Runbooks"}') }
        run_test!
      end
    end
  end

  path "/articles" do

    post "POST /articles" do
      operationId "articles_get"
      tags "Article"
      request_body required: false, content: {
        "application/json" => { schema: RT.body_schema("/articles", "post") }
      }

      response 200, "Articles queried successfully." do
        schema RT.response_schema("/articles", "post", "200")
        let(:request_body) { {} }
        run_test!
      end
    end
  end

end
