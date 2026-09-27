# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'AssetApi' do
  describe 'DELETE /asset/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/asset/{id}',
                operation_id: 'asset_id_delete')
    end
  end

  describe 'GET /asset/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/asset/{id}',
                operation_id: 'asset_id_get')
    end
  end

  describe 'PUT /asset/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/asset/{id}',
                operation_id: 'asset_id_put')
    end
  end

  describe 'POST /asset' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/asset',
                operation_id: 'asset_post')
    end
  end

  describe 'GET /assets' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/assets',
                operation_id: 'assets_get')
    end
  end

end
