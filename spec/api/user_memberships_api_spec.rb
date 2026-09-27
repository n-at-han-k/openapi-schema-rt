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

RSpec.describe 'UserMembershipsApi' do
  describe 'DELETE /user/{idOrName}/group/{groupId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/user/{idOrName}/group/{groupId}',
        operation_id: 'user_name_group_id_delete',
        mutating:     true,
        params:       { 'idOrName' => scratch(:user), 'groupId' => scratch(:group) },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'DELETE /user/{idOrName}/groups' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/user/{idOrName}/groups',
        operation_id: 'user_name_groups_delete',
        mutating:     true,
        params:       { 'idOrName' => scratch(:user) },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'PUT /user/{idOrName}/groups' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/user/{idOrName}/groups',
        operation_id: 'user_name_groups_put',
        mutating:     true,
        params:       { 'idOrName' => scratch(:user) },
        query:        nil,
        body:         [],
        setup:        nil
      )
    end
  end

end
