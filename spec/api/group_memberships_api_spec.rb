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

RSpec.describe 'GroupMembershipsApi' do
  describe 'DELETE /group/{id}/member/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/group/{id}/member/{principalId}',
        operation_id: 'group_id_member_id_delete',
        mutating:     true,
        params:       { 'id' => scratch(:group), 'principalId' => scratch(:group) },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'DELETE /group/{id}/members' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/group/{id}/members',
        operation_id: 'group_id_members_delete',
        mutating:     true,
        params:       { 'id' => scratch(:group) },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'PUT /group/{id}/members' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/group/{id}/members',
        operation_id: 'group_id_members_put',
        mutating:     true,
        params:       { 'id' => scratch(:group) },
        query:        nil,
        body:         [],
        setup:        nil
      )
    end
  end

end
