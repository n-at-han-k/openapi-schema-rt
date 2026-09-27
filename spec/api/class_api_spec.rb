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

RSpec.describe 'ClassApi' do
  describe 'DELETE /class/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/class/{idOrName}',
        operation_id: 'class_id_name_delete',
        mutating:     true,
        params:       { 'idOrName' => scratch(:class) },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'GET /class/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/class/{idOrName}',
        operation_id: 'class_id_name_get',
        mutating:     false,
        params:       { 'idOrName' => nil },
        query:        nil,
        body:         nil,
        setup:        { method: 'POST', path: '/class' }
      )
    end
  end

  describe 'PUT /class/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/class/{idOrName}',
        operation_id: 'class_id_name_put',
        mutating:     true,
        params:       { 'idOrName' => scratch(:class) },
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'POST /class' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/class',
        operation_id: 'class_post',
        mutating:     true,
        params:       {},
        query:        nil,
        body:         JSON.parse('{"Name":"Runbooks"}'),
        setup:        nil
      )
    end
  end

  describe 'GET /classes/all' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/classes/all',
        operation_id: 'classes_all_get',
        mutating:     false,
        params:       {},
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

end
