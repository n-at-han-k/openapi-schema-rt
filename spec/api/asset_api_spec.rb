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

RSpec.describe 'AssetApi' do
  describe 'GET /asset/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/asset/{id}',
        operation_id: 'asset_id_get',
        mutating:     false,
        params:       { 'id' => '56' },
        query:        nil,
        body:         nil,
        setup:        { method: 'POST', path: '/asset' }
      )
    end
  end

  describe 'PUT /asset/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/asset/{id}',
        operation_id: 'asset_id_put',
        mutating:     true,
        params:       { 'id' => scratch(:asset) },
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'POST /asset' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/asset',
        operation_id: 'asset_post',
        mutating:     true,
        params:       {},
        query:        nil,
        body:         JSON.parse('{"Name":"nathans-laptop","Catalog":"Laptops","Status":"in-use"}'),
        setup:        nil
      )
    end
  end

  describe 'GET /assets' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/assets',
        operation_id: 'assets_get',
        mutating:     false,
        params:       {},
        query:        'query=query_example',
        body:         nil,
        setup:        nil
      )
    end
  end

end
