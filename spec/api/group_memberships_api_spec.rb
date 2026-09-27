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

RSpec.describe "GroupMembershipsApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/group/{id}/member/{principalId}" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}/member/{principalId}", "id")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}/member/{principalId}", "principalId")

    delete "DELETE /group/{id}/member/{principalId}" do
      operationId "group_id_member_id_delete"
      tags "Group Memberships"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:group) }
        let(:principalId) { scratch(:group) }
        # What this removed is gone: the next example that needs one makes it.
        after { RT::Scratch.forget("group") }
        run_test!
      end
    end
  end

  path "/group/{id}/members" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}/members", "id")

    delete "DELETE /group/{id}/members" do
      operationId "group_id_members_delete"
      tags "Group Memberships"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:group) }
        # What this removed is gone: the next example that needs one makes it.
        after { RT::Scratch.forget("group") }
        run_test!
      end
    end

    put "PUT /group/{id}/members" do
      operationId "group_id_members_put"
      tags "Group Memberships"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/group/{id}/members", "put") }
      }

      response 200, "This is returned pretty much no matter what. You need to inspect the content to find out what happened." do
        schema RT.response_schema("/group/{id}/members", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:group) }
        let(:request_body) { [] }
        run_test!
      end
    end
  end

end
