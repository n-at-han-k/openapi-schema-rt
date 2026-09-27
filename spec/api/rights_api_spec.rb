# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'RightsApi' do
  describe 'GET /catalog/{idOrName}/rights/available' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/catalog/{idOrName}/rights/available',
                operation_id: 'catalog_id_name_rights_available_get')
    end
  end

  describe 'POST /catalog/{idOrName}/rights/bulk' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/catalog/{idOrName}/rights/bulk',
                operation_id: 'catalog_id_name_rights_bulk_post')
    end
  end

  describe 'GET /catalog/{idOrName}/rights' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/catalog/{idOrName}/rights',
                operation_id: 'catalog_id_name_rights_get')
    end
  end

  describe 'POST /catalog/{idOrName}/rights' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/catalog/{idOrName}/rights',
                operation_id: 'catalog_id_name_rights_post')
    end
  end

  describe 'DELETE /catalog/{idOrName}/rights/{right}/group/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/catalog/{idOrName}/rights/{right}/group/{principalId}',
                operation_id: 'catalog_id_name_rights_right_group_delete')
    end
  end

  describe 'DELETE /catalog/{idOrName}/rights/{right}/user/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/catalog/{idOrName}/rights/{right}/user/{principalId}',
                operation_id: 'catalog_id_name_rights_right_user_delete')
    end
  end

  describe 'GET /class/{idOrName}/rights/available' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/class/{idOrName}/rights/available',
                operation_id: 'class_id_name_rights_available_get')
    end
  end

  describe 'POST /class/{idOrName}/rights/bulk' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/class/{idOrName}/rights/bulk',
                operation_id: 'class_id_name_rights_bulk_post')
    end
  end

  describe 'GET /class/{idOrName}/rights' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/class/{idOrName}/rights',
                operation_id: 'class_id_name_rights_get')
    end
  end

  describe 'POST /class/{idOrName}/rights' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/class/{idOrName}/rights',
                operation_id: 'class_id_name_rights_post')
    end
  end

  describe 'DELETE /class/{idOrName}/rights/{right}/group/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/class/{idOrName}/rights/{right}/group/{principalId}',
                operation_id: 'class_id_name_rights_right_group_delete')
    end
  end

  describe 'DELETE /class/{idOrName}/rights/{right}/user/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/class/{idOrName}/rights/{right}/user/{principalId}',
                operation_id: 'class_id_name_rights_right_user_delete')
    end
  end

  describe 'GET /customfield/{id}/rights/available' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/customfield/{id}/rights/available',
                operation_id: 'customfield_id_rights_available_get')
    end
  end

  describe 'POST /customfield/{id}/rights/bulk' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/customfield/{id}/rights/bulk',
                operation_id: 'customfield_id_rights_bulk_post')
    end
  end

  describe 'GET /customfield/{id}/rights' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/customfield/{id}/rights',
                operation_id: 'customfield_id_rights_get')
    end
  end

  describe 'POST /customfield/{id}/rights' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/customfield/{id}/rights',
                operation_id: 'customfield_id_rights_post')
    end
  end

  describe 'DELETE /customfield/{id}/rights/{right}/group/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/customfield/{id}/rights/{right}/group/{principalId}',
                operation_id: 'customfield_id_rights_right_group_delete')
    end
  end

  describe 'DELETE /customfield/{id}/rights/{right}/user/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/customfield/{id}/rights/{right}/user/{principalId}',
                operation_id: 'customfield_id_rights_right_user_delete')
    end
  end

  describe 'GET /global/rights/available' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/global/rights/available',
                operation_id: 'global_rights_available_get')
    end
  end

  describe 'POST /global/rights/bulk' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/global/rights/bulk',
                operation_id: 'global_rights_bulk_post')
    end
  end

  describe 'GET /global/rights' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/global/rights',
                operation_id: 'global_rights_get')
    end
  end

  describe 'POST /global/rights' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/global/rights',
                operation_id: 'global_rights_post')
    end
  end

  describe 'DELETE /global/rights/{right}/group/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/global/rights/{right}/group/{principalId}',
                operation_id: 'global_rights_right_group_delete')
    end
  end

  describe 'DELETE /global/rights/{right}/user/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/global/rights/{right}/user/{principalId}',
                operation_id: 'global_rights_right_user_delete')
    end
  end

  describe 'GET /group/{id}/rights/available' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/group/{id}/rights/available',
                operation_id: 'group_id_rights_available_get')
    end
  end

  describe 'POST /group/{id}/rights/bulk' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/group/{id}/rights/bulk',
                operation_id: 'group_id_rights_bulk_post')
    end
  end

  describe 'GET /group/{id}/rights' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/group/{id}/rights',
                operation_id: 'group_id_rights_get')
    end
  end

  describe 'POST /group/{id}/rights' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/group/{id}/rights',
                operation_id: 'group_id_rights_post')
    end
  end

  describe 'DELETE /group/{id}/rights/{right}/group/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/group/{id}/rights/{right}/group/{principalId}',
                operation_id: 'group_id_rights_right_group_delete')
    end
  end

  describe 'DELETE /group/{id}/rights/{right}/user/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/group/{id}/rights/{right}/user/{principalId}',
                operation_id: 'group_id_rights_right_user_delete')
    end
  end

  describe 'GET /queue/{idOrName}/rights/available' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/queue/{idOrName}/rights/available',
                operation_id: 'queue_id_name_rights_available_get')
    end
  end

  describe 'POST /queue/{idOrName}/rights/bulk' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/queue/{idOrName}/rights/bulk',
                operation_id: 'queue_id_name_rights_bulk_post')
    end
  end

  describe 'GET /queue/{idOrName}/rights' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/queue/{idOrName}/rights',
                operation_id: 'queue_id_name_rights_get')
    end
  end

  describe 'POST /queue/{idOrName}/rights' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/queue/{idOrName}/rights',
                operation_id: 'queue_id_name_rights_post')
    end
  end

  describe 'DELETE /queue/{idOrName}/rights/{right}/group/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/queue/{idOrName}/rights/{right}/group/{principalId}',
                operation_id: 'queue_id_name_rights_right_group_delete')
    end
  end

  describe 'DELETE /queue/{idOrName}/rights/{right}/user/{principalId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/queue/{idOrName}/rights/{right}/user/{principalId}',
                operation_id: 'queue_id_name_rights_right_user_delete')
    end
  end

end
