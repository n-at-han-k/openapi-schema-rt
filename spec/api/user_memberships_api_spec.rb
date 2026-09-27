# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'UserMembershipsApi' do
  describe 'DELETE /user/{idOrName}/group/{groupId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/user/{idOrName}/group/{groupId}',
                operation_id: 'user_name_group_id_delete')
    end
  end

  describe 'DELETE /user/{idOrName}/groups' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/user/{idOrName}/groups',
                operation_id: 'user_name_groups_delete')
    end
  end

  describe 'PUT /user/{idOrName}/groups' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/user/{idOrName}/groups',
                operation_id: 'user_name_groups_put')
    end
  end

end
