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

RSpec.describe 'LifecycleApi' do
  describe 'DELETE /lifecycle/{name}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/lifecycle/{name}',
        operation_id: 'lifecycle_name_delete',
        mutating:     true,
        params:       { 'name' => scratch(:lifecycle) },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'GET /lifecycle/{name}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/lifecycle/{name}',
        operation_id: 'lifecycle_name_get',
        mutating:     false,
        params:       { 'name' => 'support' },
        query:        nil,
        body:         nil,
        setup:        { method: 'POST', path: '/lifecycles' }
      )
    end
  end

  describe 'GET /lifecycle/{name}/maps' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/lifecycle/{name}/maps',
        operation_id: 'lifecycle_name_maps_get',
        mutating:     false,
        params:       { 'name' => 'support' },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'PUT /lifecycle/{name}/maps' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/lifecycle/{name}/maps',
        operation_id: 'lifecycle_name_maps_put',
        mutating:     true,
        params:       { 'name' => scratch(:lifecycle) },
        query:        nil,
        body:         JSON.parse('Object'),
        setup:        nil
      )
    end
  end

  describe 'PUT /lifecycle/{name}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/lifecycle/{name}',
        operation_id: 'lifecycle_name_put',
        mutating:     true,
        params:       { 'name' => scratch(:lifecycle) },
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'POST /lifecycle/{name}/validate' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/lifecycle/{name}/validate',
        operation_id: 'lifecycle_name_validate_post',
        mutating:     false,
        params:       { 'name' => 'support' },
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'GET /lifecycles' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/lifecycles',
        operation_id: 'lifecycles_get',
        mutating:     false,
        params:       {},
        query:        'type=type_example',
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'POST /lifecycles' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/lifecycles',
        operation_id: 'lifecycles_post',
        mutating:     true,
        params:       {},
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

end
