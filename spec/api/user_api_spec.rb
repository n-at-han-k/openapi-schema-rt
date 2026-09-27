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

RSpec.describe "UserApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/user/{idOrName}" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/user/{idOrName}", "idOrName")

    delete "DELETE /user/{idOrName}" do
      operationId "user_id_name_delete"
      tags "User"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:user) }
        run_test!
      end
    end

    get "GET /user/{idOrName}" do
      operationId "user_id_name_get"
      tags "User"

      response 200, "Successfully fetched user info." do
        schema RT.response_schema("/user/{idOrName}", "get", "200")
        let(:idOrName) { 'General' }
        run_test!
      end
    end

    put "PUT /user/{idOrName}" do
      operationId "user_id_name_put"
      tags "User"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/user/{idOrName}", "put") }
      }

      response 200, "This is returned pretty much always. You need to inspect the content to figure out what happened." do
        schema RT.response_schema("/user/{idOrName}", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:user) }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/user" do

    post "POST /user" do
      operationId "user_post"
      tags "User"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/user", "post") }
      }

      response 201, "User created successfully." do
        schema RT.response_schema("/user", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:request_body) { JSON.parse('{"Name":"NewUser","Privileged":1,"Password":"Color Out of Space is an intriguing story by Lovecraft."}') }
        run_test!
      end
    end
  end

  path "/users" do

    post "POST /users" do
      operationId "users_get"
      tags "User"
      request_body required: false, content: {
        "application/json" => { schema: RT.body_schema("/users", "post") }
      }

      response 200, "Search successful" do
        schema RT.response_schema("/users", "post", "200")
        let(:request_body) { JSON.parse('[{"field":"Name","value":"userid","operator":"LIKE"}]') }
        run_test!
      end
    end
  end

end
