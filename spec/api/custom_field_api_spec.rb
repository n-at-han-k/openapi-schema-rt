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

RSpec.describe 'CustomFieldApi' do
  describe 'GET /catalog/{id}/customfields' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/catalog/{id}/customfields',
        operation_id: 'catalog_id_customfields_get',
        mutating:     false,
        params:       { 'id' => '56' },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'GET /class/{id}/customfields' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/class/{id}/customfields',
        operation_id: 'class_id_customfields_get',
        mutating:     false,
        params:       { 'id' => '56' },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'GET /customfield/{id}/appliesto' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/customfield/{id}/appliesto',
        operation_id: 'customfield_id_appliesto_get',
        mutating:     false,
        params:       { 'id' => '56' },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'DELETE /customfield/{id}/appliesto/object/{objectId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/customfield/{id}/appliesto/object/{objectId}',
        operation_id: 'customfield_id_appliesto_object_delete',
        mutating:     true,
        params:       { 'id' => scratch(:customfield), 'objectId' => scratch(:queue) },
        query:        nil,
        body:         nil,
        setup:        { method: 'POST', path: '/customfield/{id}/appliesto' }
      )
    end
  end

  describe 'POST /customfield/{id}/appliesto' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/customfield/{id}/appliesto',
        operation_id: 'customfield_id_appliesto_post',
        mutating:     true,
        params:       { 'id' => scratch(:customfield) },
        query:        nil,
        body:         JSON.parse('{"ObjectId":1}'),
        setup:        nil
      )
    end
  end

  describe 'DELETE /customfield/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/customfield/{id}',
        operation_id: 'customfield_id_delete',
        mutating:     true,
        params:       { 'id' => scratch(:customfield) },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'GET /customfield/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/customfield/{id}',
        operation_id: 'customfield_id_get',
        mutating:     false,
        params:       { 'id' => '56' },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'PUT /customfield/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/customfield/{id}',
        operation_id: 'customfield_id_put',
        mutating:     true,
        params:       { 'id' => scratch(:customfield) },
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'DELETE /customfield/{id}/value/{valueId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/customfield/{id}/value/{valueId}',
        operation_id: 'customfield_id_value_id_delete',
        mutating:     true,
        params:       { 'id' => scratch(:customfield), 'valueId' => :scratch_value },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'GET /customfield/{id}/value/{valueId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/customfield/{id}/value/{valueId}',
        operation_id: 'customfield_id_value_id_get',
        mutating:     false,
        params:       { 'id' => '56', 'valueId' => '56' },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'PUT /customfield/{id}/value/{valueId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/customfield/{id}/value/{valueId}',
        operation_id: 'customfield_id_value_id_put',
        mutating:     true,
        params:       { 'id' => scratch(:customfield), 'valueId' => :scratch_value },
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'POST /customfield/{id}/value' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/customfield/{id}/value',
        operation_id: 'customfield_id_value_post',
        mutating:     true,
        params:       { 'id' => scratch(:customfield) },
        query:        nil,
        body:         JSON.parse('{"Name":"High","SortOrder":"1"}'),
        setup:        nil
      )
    end
  end

  describe 'GET /customfield/{id}/values' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/customfield/{id}/values',
        operation_id: 'customfield_id_values_get',
        mutating:     false,
        params:       { 'id' => '56' },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'POST /customfield' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/customfield',
        operation_id: 'customfield_post',
        mutating:     true,
        params:       {},
        query:        nil,
        body:         JSON.parse('{"Name":"Delivery Date","Type":"Date","MaxValues":"1","LookupType":"RT::Queue-RT::Ticket"}'),
        setup:        nil
      )
    end
  end

  describe 'POST /customfields' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/customfields',
        operation_id: 'customfields_post',
        mutating:     false,
        params:       {},
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'GET /queue/{id}/customfields' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/queue/{id}/customfields',
        operation_id: 'queue_id_customfields_get',
        mutating:     false,
        params:       { 'id' => '56' },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

end
