# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'LifecycleApi' do
  describe 'DELETE /lifecycle/{name}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/lifecycle/{name}',
                operation_id: 'lifecycle_name_delete')
    end
  end

  describe 'GET /lifecycle/{name}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/lifecycle/{name}',
                operation_id: 'lifecycle_name_get')
    end
  end

  describe 'GET /lifecycle/{name}/maps' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/lifecycle/{name}/maps',
                operation_id: 'lifecycle_name_maps_get')
    end
  end

  describe 'PUT /lifecycle/{name}/maps' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/lifecycle/{name}/maps',
                operation_id: 'lifecycle_name_maps_put')
    end
  end

  describe 'PUT /lifecycle/{name}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/lifecycle/{name}',
                operation_id: 'lifecycle_name_put')
    end
  end

  describe 'POST /lifecycle/{name}/validate' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/lifecycle/{name}/validate',
                operation_id: 'lifecycle_name_validate_post')
    end
  end

  describe 'GET /lifecycles' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/lifecycles',
                operation_id: 'lifecycles_get')
    end
  end

  describe 'POST /lifecycles' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/lifecycles',
                operation_id: 'lifecycles_post')
    end
  end

end
