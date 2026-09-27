# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'GroupMembershipsApi' do
  describe 'DELETE /group/{id}/member/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/group/{id}/member/{principalId}',
                operation_id: 'group_id_member_id_delete')
    end
  end

  describe 'DELETE /group/{id}/members' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/group/{id}/members',
                operation_id: 'group_id_members_delete')
    end
  end

  describe 'PUT /group/{id}/members' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/group/{id}/members',
                operation_id: 'group_id_members_put')
    end
  end

end
