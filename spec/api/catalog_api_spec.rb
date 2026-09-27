# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'CatalogApi' do
  describe 'DELETE /catalog/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/catalog/{idOrName}',
                operation_id: 'catalog_id_name_delete')
    end
  end

  describe 'GET /catalog/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/catalog/{idOrName}',
                operation_id: 'catalog_id_name_get')
    end
  end

  describe 'PUT /catalog/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/catalog/{idOrName}',
                operation_id: 'catalog_id_name_put')
    end
  end

  describe 'POST /catalog' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/catalog',
                operation_id: 'catalog_post')
    end
  end

  describe 'GET /catalogs/all' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/catalogs/all',
                operation_id: 'catalogs_all_get')
    end
  end

end
