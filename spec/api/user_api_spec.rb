# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'UserApi' do
  describe 'DELETE /user/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/user/{idOrName}',
                operation_id: 'user_id_name_delete')
    end
  end

  describe 'GET /user/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/user/{idOrName}',
                operation_id: 'user_id_name_get')
    end
  end

  describe 'PUT /user/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/user/{idOrName}',
                operation_id: 'user_id_name_put')
    end
  end

  describe 'POST /user' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/user',
                operation_id: 'user_post')
    end
  end

  describe 'POST /users' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/users',
                operation_id: 'users_get')
    end
  end

end
