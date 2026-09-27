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

RSpec.describe 'CatalogApi' do
  describe 'DELETE /catalog/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/catalog/{idOrName}',
        operation_id: 'catalog_id_name_delete',
        mutating:     true,
        params:       { 'idOrName' => scratch(:catalog) },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'GET /catalog/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/catalog/{idOrName}',
        operation_id: 'catalog_id_name_get',
        mutating:     false,
        params:       { 'idOrName' => nil },
        query:        nil,
        body:         nil,
        setup:        { method: 'POST', path: '/catalog' }
      )
    end
  end

  describe 'PUT /catalog/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/catalog/{idOrName}',
        operation_id: 'catalog_id_name_put',
        mutating:     true,
        params:       { 'idOrName' => scratch(:catalog) },
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'POST /catalog' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/catalog',
        operation_id: 'catalog_post',
        mutating:     true,
        params:       {},
        query:        nil,
        body:         JSON.parse('{"Name":"Laptops","Lifecycle":"assets"}'),
        setup:        nil
      )
    end
  end

  describe 'GET /catalogs/all' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/catalogs/all',
        operation_id: 'catalogs_all_get',
        mutating:     false,
        params:       {},
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

end
