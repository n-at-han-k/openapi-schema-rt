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

RSpec.describe "QueueApi", type: :openapi do
  openapi_schema :request_tracker_rest2

  path "/queue/{idOrName}" do
    parameter name: :idOrName, in: :path, required: true,
              schema: RT.parameter_schema("/queue/{idOrName}", "idOrName")

    delete "DELETE /queue/{idOrName}" do
      operationId "queue_id_name_delete"
      tags "Queue"

      response 204, "Success, no content." do
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:queue) }
        # What this removed is gone: the next example that needs one makes it.
        after { RT::Scratch.forget("queue") }
        run_test!
      end
    end

    get "GET /queue/{idOrName}" do
      operationId "queue_id_name_get"
      tags "Queue"

      response 200, "Queue queried successfully." do
        schema RT.response_schema("/queue/{idOrName}", "get", "200")
        let(:idOrName) { 'General' }
        run_test!
      end
    end

    put "PUT /queue/{idOrName}" do
      operationId "queue_id_name_put"
      tags "Queue"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/queue/{idOrName}", "put") }
      }

      response 200, "This is returned pretty much always. You need to inspect the content to figure out what happened." do
        schema RT.response_schema("/queue/{idOrName}", "put", "200")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:idOrName) { scratch(:queue) }
        let(:request_body) { { 'Name' => unique('conf') } }
        run_test!
      end
    end
  end

  path "/queue" do

    post "POST /queue" do
      operationId "queue_post"
      tags "Queue"
      request_body required: true, content: {
        "application/json" => { schema: RT.body_schema("/queue", "post") }
      }

      response 201, "Queue created successfully." do
        schema RT.response_schema("/queue", "post", "201")
        # This one writes. It is aimed at an object the suite makes and removes,
        # never at anything that was in RT beforehand -- but it writes, so it
        # runs only when asked for.
        before { skip("changes state; bin/test --mutate to include it") unless RT::MUTATE }
        let(:request_body) { { 'Name' => unique('conf') } }
        run_test!
      end
    end
  end

  path "/queues/all" do

    get "GET /queues/all" do
      operationId "queues_all_get"
      tags "Queue"

      response 200, "Queue queried successfully." do
        schema RT.response_schema("/queues/all", "get", "200")
        run_test!
      end
    end
  end

end
