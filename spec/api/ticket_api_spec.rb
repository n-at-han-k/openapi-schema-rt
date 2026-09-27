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

RSpec.describe 'TicketApi' do
  describe 'DELETE /ticket/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/ticket/{id}',
        operation_id: 'ticket_id_delete',
        mutating:     true,
        params:       { 'id' => scratch(:ticket) },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'GET /ticket/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/ticket/{id}',
        operation_id: 'ticket_id_get',
        mutating:     false,
        params:       { 'id' => '56' },
        query:        nil,
        body:         nil,
        setup:        { method: 'POST', path: '/ticket' }
      )
    end
  end

  describe 'PUT /ticket/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/ticket/{id}',
        operation_id: 'ticket_id_put',
        mutating:     true,
        params:       { 'id' => scratch(:ticket) },
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'POST /ticket' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/ticket',
        operation_id: 'ticket_post',
        mutating:     true,
        params:       {},
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'GET /tickets' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/tickets',
        operation_id: 'tickets_get',
        mutating:     false,
        params:       {},
        query:        'query=query_example&search=search_example',
        body:         nil,
        setup:        nil
      )
    end
  end

end
