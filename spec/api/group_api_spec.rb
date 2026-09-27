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

RSpec.describe 'GroupApi' do
  describe 'DELETE /group/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/group/{id}',
        operation_id: 'group_id_delete',
        mutating:     true,
        params:       { 'id' => scratch(:group) },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'GET /group/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/group/{id}',
        operation_id: 'group_id_get',
        mutating:     false,
        params:       { 'id' => '56' },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'PUT /group/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/group/{id}',
        operation_id: 'group_id_put',
        mutating:     true,
        params:       { 'id' => scratch(:group) },
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'POST /group' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/group',
        operation_id: 'group_post',
        mutating:     true,
        params:       {},
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'POST /groups' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/groups',
        operation_id: 'groups_post',
        mutating:     false,
        params:       {},
        query:        'query=query_example',
        body:         {},
        setup:        nil
      )
    end
  end

end
