# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes, carrying what that
# operation needs: which object to aim it at, and what to send. All of it is
# decided by the generator from the document -- see
# generators/rspec/src/rtrspec/RspecCodegen.java. spec_helper.rb knows nothing
# about any particular endpoint.

require 'spec_helper'

RSpec.describe 'QueueApi' do
  describe 'DELETE /queue/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/queue/{idOrName}',
        operation_id: 'queue_id_name_delete',
        mutating:     true,
        params:       { 'idOrName' => scratch(:queue) },
        query:        nil,
        body:         nil,
        setup:        { method: 'GET', path: '/queue/{idOrName}' }
      )
    end
  end

  describe 'GET /queue/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/queue/{idOrName}',
        operation_id: 'queue_id_name_get',
        mutating:     false,
        params:       { 'idOrName' => nil },
        query:        nil,
        body:         nil,
        setup:        { method: 'POST', path: '/queue' }
      )
    end
  end

  describe 'PUT /queue/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/queue/{idOrName}',
        operation_id: 'queue_id_name_put',
        mutating:     true,
        params:       { 'idOrName' => scratch(:queue) },
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'POST /queue' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/queue',
        operation_id: 'queue_post',
        mutating:     true,
        params:       {},
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'GET /queues/all' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/queues/all',
        operation_id: 'queues_all_get',
        mutating:     false,
        params:       {},
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

end
