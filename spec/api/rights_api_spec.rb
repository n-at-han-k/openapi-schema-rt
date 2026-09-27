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

RSpec.describe "RightsApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/catalog/{idOrName}/rights/available" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/catalog/{idOrName}/rights/available", "idOrName")

    get "GET /catalog/{idOrName}/rights/available" do
      operationId "catalog_id_name_rights_available_get"
      tags "Rights"

      response 200, "Available rights queried successfully." do
        schema RT.response_schema("/catalog/{idOrName}/rights/available", "get", "200")
        let(:idOrName) { 'General' }
        run_test!
      end
    end
  end

  path "/catalog/{idOrName}/rights/bulk" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/catalog/{idOrName}/rights/bulk", "idOrName")

    post "POST /catalog/{idOrName}/rights/bulk" do
      operationId "catalog_id_name_rights_bulk_post"
      tags "Rights"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/catalog/{idOrName}/rights/bulk", "post") }
      }

      response 200, "The changes were applied. Read the body to find out what happened to each one." do
        schema RT.response_schema("/catalog/{idOrName}/rights/bulk", "post", "200")
        let(:idOrName) { 'General' }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/catalog/{idOrName}/rights" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/catalog/{idOrName}/rights", "idOrName")

    get "GET /catalog/{idOrName}/rights" do
      operationId "catalog_id_name_rights_get"
      tags "Rights"

      response 200, "Rights queried successfully." do
        schema RT.response_schema("/catalog/{idOrName}/rights", "get", "200")
        let(:idOrName) { 'General' }
        run_test!
      end
    end

    post "POST /catalog/{idOrName}/rights" do
      operationId "catalog_id_name_rights_post"
      tags "Rights"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/catalog/{idOrName}/rights", "post") }
      }

      response 201, "Right granted successfully." do
        schema RT.response_schema("/catalog/{idOrName}/rights", "post", "201")
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

  path "/catalog/{idOrName}/rights/{right}/group/{principalId}" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/catalog/{idOrName}/rights/{right}/group/{principalId}", "idOrName")
    parameter name: :right, in: :path, required: true,
              schema: RT.parameter_schema("/catalog/{idOrName}/rights/{right}/group/{principalId}", "right")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/catalog/{idOrName}/rights/{right}/group/{principalId}", "principalId")

    delete "DELETE /catalog/{idOrName}/rights/{right}/group/{principalId}" do
      operationId "catalog_id_name_rights_right_group_delete"
      tags "Rights"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:catalog) }
        let(:right) { 'SeeQueue' }
        let(:principalId) { scratch(:group) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/catalog/{idOrName}/rights", { 'idOrName' => id_or_name, 'right' => right, 'principalId' => principal_id }) }
        run_test!
      end
    end
  end

  path "/catalog/{idOrName}/rights/{right}/user/{principalId}" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/catalog/{idOrName}/rights/{right}/user/{principalId}", "idOrName")
    parameter name: :right, in: :path, required: true,
              schema: RT.parameter_schema("/catalog/{idOrName}/rights/{right}/user/{principalId}", "right")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/catalog/{idOrName}/rights/{right}/user/{principalId}", "principalId")

    delete "DELETE /catalog/{idOrName}/rights/{right}/user/{principalId}" do
      operationId "catalog_id_name_rights_right_user_delete"
      tags "Rights"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:catalog) }
        let(:right) { 'SeeQueue' }
        let(:principalId) { scratch(:user) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/catalog/{idOrName}/rights", { 'idOrName' => id_or_name, 'right' => right, 'principalId' => principal_id }) }
        run_test!
      end
    end
  end

  path "/class/{idOrName}/rights/available" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/class/{idOrName}/rights/available", "idOrName")

    get "GET /class/{idOrName}/rights/available" do
      operationId "class_id_name_rights_available_get"
      tags "Rights"

      response 200, "Available rights queried successfully." do
        schema RT.response_schema("/class/{idOrName}/rights/available", "get", "200")
        let(:idOrName) { 'General' }
        run_test!
      end
    end
  end

  path "/class/{idOrName}/rights/bulk" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/class/{idOrName}/rights/bulk", "idOrName")

    post "POST /class/{idOrName}/rights/bulk" do
      operationId "class_id_name_rights_bulk_post"
      tags "Rights"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/class/{idOrName}/rights/bulk", "post") }
      }

      response 200, "The changes were applied. Read the body to find out what happened to each one." do
        schema RT.response_schema("/class/{idOrName}/rights/bulk", "post", "200")
        let(:idOrName) { 'General' }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/class/{idOrName}/rights" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/class/{idOrName}/rights", "idOrName")

    get "GET /class/{idOrName}/rights" do
      operationId "class_id_name_rights_get"
      tags "Rights"

      response 200, "Rights queried successfully." do
        schema RT.response_schema("/class/{idOrName}/rights", "get", "200")
        let(:idOrName) { 'General' }
        run_test!
      end
    end

    post "POST /class/{idOrName}/rights" do
      operationId "class_id_name_rights_post"
      tags "Rights"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/class/{idOrName}/rights", "post") }
      }

      response 201, "Right granted successfully." do
        schema RT.response_schema("/class/{idOrName}/rights", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:class) }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/class/{idOrName}/rights/{right}/group/{principalId}" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/class/{idOrName}/rights/{right}/group/{principalId}", "idOrName")
    parameter name: :right, in: :path, required: true,
              schema: RT.parameter_schema("/class/{idOrName}/rights/{right}/group/{principalId}", "right")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/class/{idOrName}/rights/{right}/group/{principalId}", "principalId")

    delete "DELETE /class/{idOrName}/rights/{right}/group/{principalId}" do
      operationId "class_id_name_rights_right_group_delete"
      tags "Rights"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:class) }
        let(:right) { 'SeeQueue' }
        let(:principalId) { scratch(:group) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/class/{idOrName}/rights", { 'idOrName' => id_or_name, 'right' => right, 'principalId' => principal_id }) }
        run_test!
      end
    end
  end

  path "/class/{idOrName}/rights/{right}/user/{principalId}" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/class/{idOrName}/rights/{right}/user/{principalId}", "idOrName")
    parameter name: :right, in: :path, required: true,
              schema: RT.parameter_schema("/class/{idOrName}/rights/{right}/user/{principalId}", "right")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/class/{idOrName}/rights/{right}/user/{principalId}", "principalId")

    delete "DELETE /class/{idOrName}/rights/{right}/user/{principalId}" do
      operationId "class_id_name_rights_right_user_delete"
      tags "Rights"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:class) }
        let(:right) { 'SeeQueue' }
        let(:principalId) { scratch(:user) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/class/{idOrName}/rights", { 'idOrName' => id_or_name, 'right' => right, 'principalId' => principal_id }) }
        run_test!
      end
    end
  end

  path "/customfield/{id}/rights/available" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/rights/available", "id")

    get "GET /customfield/{id}/rights/available" do
      operationId "customfield_id_rights_available_get"
      tags "Rights"

      response 200, "Available rights queried successfully." do
        schema RT.response_schema("/customfield/{id}/rights/available", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end
  end

  path "/customfield/{id}/rights/bulk" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/rights/bulk", "id")

    post "POST /customfield/{id}/rights/bulk" do
      operationId "customfield_id_rights_bulk_post"
      tags "Rights"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/customfield/{id}/rights/bulk", "post") }
      }

      response 200, "The changes were applied. Read the body to find out what happened to each one." do
        schema RT.response_schema("/customfield/{id}/rights/bulk", "post", "200")
        let(:id) { '1' }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/customfield/{id}/rights" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/rights", "id")

    get "GET /customfield/{id}/rights" do
      operationId "customfield_id_rights_get"
      tags "Rights"

      response 200, "Rights queried successfully." do
        schema RT.response_schema("/customfield/{id}/rights", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end

    post "POST /customfield/{id}/rights" do
      operationId "customfield_id_rights_post"
      tags "Rights"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/customfield/{id}/rights", "post") }
      }

      response 201, "Right granted successfully." do
        schema RT.response_schema("/customfield/{id}/rights", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:customfield) }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/customfield/{id}/rights/{right}/group/{principalId}" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/rights/{right}/group/{principalId}", "id")
    parameter name: :right, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/rights/{right}/group/{principalId}", "right")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/rights/{right}/group/{principalId}", "principalId")

    delete "DELETE /customfield/{id}/rights/{right}/group/{principalId}" do
      operationId "customfield_id_rights_right_group_delete"
      tags "Rights"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:customfield) }
        let(:right) { 'SeeQueue' }
        let(:principalId) { scratch(:group) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/customfield/{id}/rights", { 'id' => id, 'right' => right, 'principalId' => principal_id }) }
        run_test!
      end
    end
  end

  path "/customfield/{id}/rights/{right}/user/{principalId}" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/rights/{right}/user/{principalId}", "id")
    parameter name: :right, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/rights/{right}/user/{principalId}", "right")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/customfield/{id}/rights/{right}/user/{principalId}", "principalId")

    delete "DELETE /customfield/{id}/rights/{right}/user/{principalId}" do
      operationId "customfield_id_rights_right_user_delete"
      tags "Rights"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:customfield) }
        let(:right) { 'SeeQueue' }
        let(:principalId) { scratch(:user) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/customfield/{id}/rights", { 'id' => id, 'right' => right, 'principalId' => principal_id }) }
        run_test!
      end
    end
  end

  path "/global/rights/available" do

    get "GET /global/rights/available" do
      operationId "global_rights_available_get"
      tags "Rights"

      response 200, "Available rights queried successfully." do
        schema RT.response_schema("/global/rights/available", "get", "200")
        run_test!
      end
    end
  end

  path "/global/rights/bulk" do

    post "POST /global/rights/bulk" do
      operationId "global_rights_bulk_post"
      tags "Rights"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/global/rights/bulk", "post") }
      }

      response 200, "The changes were applied. Read the body to find out what happened to each one." do
        schema RT.response_schema("/global/rights/bulk", "post", "200")
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/global/rights" do

    get "GET /global/rights" do
      operationId "global_rights_get"
      tags "Rights"

      response 200, "Rights queried successfully." do
        schema RT.response_schema("/global/rights", "get", "200")
        run_test!
      end
    end

    post "POST /global/rights" do
      operationId "global_rights_post"
      tags "Rights"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/global/rights", "post") }
      }

      response 201, "Right granted successfully." do
        schema RT.response_schema("/global/rights", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/global/rights/{right}/group/{principalId}" do
    parameter name: :right, in: :path, required: true,
              schema: RT.parameter_schema("/global/rights/{right}/group/{principalId}", "right")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/global/rights/{right}/group/{principalId}", "principalId")

    delete "DELETE /global/rights/{right}/group/{principalId}" do
      operationId "global_rights_right_group_delete"
      tags "Rights"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:right) { 'SeeQueue' }
        let(:principalId) { scratch(:group) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/global/rights", { 'right' => right, 'principalId' => principal_id }) }
        run_test!
      end
    end
  end

  path "/global/rights/{right}/user/{principalId}" do
    parameter name: :right, in: :path, required: true,
              schema: RT.parameter_schema("/global/rights/{right}/user/{principalId}", "right")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/global/rights/{right}/user/{principalId}", "principalId")

    delete "DELETE /global/rights/{right}/user/{principalId}" do
      operationId "global_rights_right_user_delete"
      tags "Rights"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:right) { 'SeeQueue' }
        let(:principalId) { scratch(:user) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/global/rights", { 'right' => right, 'principalId' => principal_id }) }
        run_test!
      end
    end
  end

  path "/group/{id}/rights/available" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}/rights/available", "id")

    get "GET /group/{id}/rights/available" do
      operationId "group_id_rights_available_get"
      tags "Rights"

      response 200, "Available rights queried successfully." do
        schema RT.response_schema("/group/{id}/rights/available", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end
  end

  path "/group/{id}/rights/bulk" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}/rights/bulk", "id")

    post "POST /group/{id}/rights/bulk" do
      operationId "group_id_rights_bulk_post"
      tags "Rights"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/group/{id}/rights/bulk", "post") }
      }

      response 200, "The changes were applied. Read the body to find out what happened to each one." do
        schema RT.response_schema("/group/{id}/rights/bulk", "post", "200")
        let(:id) { '1' }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/group/{id}/rights" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}/rights", "id")

    get "GET /group/{id}/rights" do
      operationId "group_id_rights_get"
      tags "Rights"

      response 200, "Rights queried successfully." do
        schema RT.response_schema("/group/{id}/rights", "get", "200")
        let(:id) { '1' }
        run_test!
      end
    end

    post "POST /group/{id}/rights" do
      operationId "group_id_rights_post"
      tags "Rights"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/group/{id}/rights", "post") }
      }

      response 201, "Right granted successfully." do
        schema RT.response_schema("/group/{id}/rights", "post", "201")
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

  path "/group/{id}/rights/{right}/group/{principalId}" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}/rights/{right}/group/{principalId}", "id")
    parameter name: :right, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}/rights/{right}/group/{principalId}", "right")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}/rights/{right}/group/{principalId}", "principalId")

    delete "DELETE /group/{id}/rights/{right}/group/{principalId}" do
      operationId "group_id_rights_right_group_delete"
      tags "Rights"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:group) }
        let(:right) { 'SeeQueue' }
        let(:principalId) { scratch(:group) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/group/{id}/rights", { 'id' => id, 'right' => right, 'principalId' => principal_id }) }
        run_test!
      end
    end
  end

  path "/group/{id}/rights/{right}/user/{principalId}" do
    parameter name: :id, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}/rights/{right}/user/{principalId}", "id")
    parameter name: :right, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}/rights/{right}/user/{principalId}", "right")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/group/{id}/rights/{right}/user/{principalId}", "principalId")

    delete "DELETE /group/{id}/rights/{right}/user/{principalId}" do
      operationId "group_id_rights_right_user_delete"
      tags "Rights"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:id) { scratch(:group) }
        let(:right) { 'SeeQueue' }
        let(:principalId) { scratch(:user) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/group/{id}/rights", { 'id' => id, 'right' => right, 'principalId' => principal_id }) }
        run_test!
      end
    end
  end

  path "/queue/{idOrName}/rights/available" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/queue/{idOrName}/rights/available", "idOrName")

    get "GET /queue/{idOrName}/rights/available" do
      operationId "queue_id_name_rights_available_get"
      tags "Rights"

      response 200, "Available rights queried successfully." do
        schema RT.response_schema("/queue/{idOrName}/rights/available", "get", "200")
        let(:idOrName) { 'General' }
        run_test!
      end
    end
  end

  path "/queue/{idOrName}/rights/bulk" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/queue/{idOrName}/rights/bulk", "idOrName")

    post "POST /queue/{idOrName}/rights/bulk" do
      operationId "queue_id_name_rights_bulk_post"
      tags "Rights"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/queue/{idOrName}/rights/bulk", "post") }
      }

      response 200, "The changes were applied. Read the body to find out what happened to each one." do
        schema RT.response_schema("/queue/{idOrName}/rights/bulk", "post", "200")
        let(:idOrName) { 'General' }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/queue/{idOrName}/rights" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/queue/{idOrName}/rights", "idOrName")

    get "GET /queue/{idOrName}/rights" do
      operationId "queue_id_name_rights_get"
      tags "Rights"

      response 200, "Rights queried successfully." do
        schema RT.response_schema("/queue/{idOrName}/rights", "get", "200")
        let(:idOrName) { 'General' }
        run_test!
      end
    end

    post "POST /queue/{idOrName}/rights" do
      operationId "queue_id_name_rights_post"
      tags "Rights"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/queue/{idOrName}/rights", "post") }
      }

      response 201, "Right granted successfully." do
        schema RT.response_schema("/queue/{idOrName}/rights", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:queue) }
        let(:request_body) { {} }
        run_test!
      end
    end
  end

  path "/queue/{idOrName}/rights/{right}/group/{principalId}" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/queue/{idOrName}/rights/{right}/group/{principalId}", "idOrName")
    parameter name: :right, in: :path, required: true,
              schema: RT.parameter_schema("/queue/{idOrName}/rights/{right}/group/{principalId}", "right")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/queue/{idOrName}/rights/{right}/group/{principalId}", "principalId")

    delete "DELETE /queue/{idOrName}/rights/{right}/group/{principalId}" do
      operationId "queue_id_name_rights_right_group_delete"
      tags "Rights"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:queue) }
        let(:right) { 'SeeQueue' }
        let(:principalId) { scratch(:group) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/queue/{idOrName}/rights", { 'idOrName' => id_or_name, 'right' => right, 'principalId' => principal_id }) }
        run_test!
      end
    end
  end

  path "/queue/{idOrName}/rights/{right}/user/{principalId}" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/queue/{idOrName}/rights/{right}/user/{principalId}", "idOrName")
    parameter name: :right, in: :path, required: true,
              schema: RT.parameter_schema("/queue/{idOrName}/rights/{right}/user/{principalId}", "right")
    parameter name: :principalId, in: :path, required: true,
              schema: RT.parameter_schema("/queue/{idOrName}/rights/{right}/user/{principalId}", "principalId")

    delete "DELETE /queue/{idOrName}/rights/{right}/user/{principalId}" do
      operationId "queue_id_name_rights_right_user_delete"
      tags "Rights"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:queue) }
        let(:right) { 'SeeQueue' }
        let(:principalId) { scratch(:user) }
        # What has to exist first, from the document's own link between the two
        # operations: RT answers 500 to a revoke of a right it never granted.
        before { RT.setup("POST", "/queue/{idOrName}/rights", { 'idOrName' => id_or_name, 'right' => right, 'principalId' => principal_id }) }
        run_test!
      end
    end
  end

end
