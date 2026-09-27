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

RSpec.describe "UserMembershipsApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/user/{idOrName}/group/{groupId}" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/user/{idOrName}/group/{groupId}", "idOrName")
    parameter name: :groupId, in: :path, required: true,
              schema: RT.parameter_schema("/user/{idOrName}/group/{groupId}", "groupId")

    delete "DELETE /user/{idOrName}/group/{groupId}" do
      operationId "user_name_group_id_delete"
      tags "User Memberships"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:user) }
        let(:groupId) { scratch(:group) }
        run_test!
      end
    end
  end

  path "/user/{idOrName}/groups" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/user/{idOrName}/groups", "idOrName")

    delete "DELETE /user/{idOrName}/groups" do
      operationId "user_name_groups_delete"
      tags "User Memberships"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:user) }
        run_test!
      end
    end

    put "PUT /user/{idOrName}/groups" do
      operationId "user_name_groups_put"
      tags "User Memberships"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/user/{idOrName}/groups", "put") }
      }

      response 200, "This is returned pretty much no matter what. You need to inspect the content to find out what happened." do
        schema RT.response_schema("/user/{idOrName}/groups", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:user) }
        let(:request_body) { [] }
        run_test!
      end
    end
  end

end
