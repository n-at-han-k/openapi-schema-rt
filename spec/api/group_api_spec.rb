# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'GroupApi' do
  describe 'DELETE /group/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/group/{id}',
                operation_id: 'group_id_delete')
    end
  end

  describe 'GET /group/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/group/{id}',
                operation_id: 'group_id_get')
    end
  end

  describe 'PUT /group/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/group/{id}',
                operation_id: 'group_id_put')
    end
  end

  describe 'POST /group' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/group',
                operation_id: 'group_post')
    end
  end

  describe 'POST /groups' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/groups',
                operation_id: 'groups_post')
    end
  end

end
