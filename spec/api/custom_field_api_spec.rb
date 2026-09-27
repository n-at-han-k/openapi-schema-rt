# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'CustomFieldApi' do
  describe 'DELETE /customfield/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/customfield/{id}',
                operation_id: 'customfield_id_delete')
    end
  end

  describe 'GET /customfield/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/customfield/{id}',
                operation_id: 'customfield_id_get')
    end
  end

  describe 'PUT /customfield/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/customfield/{id}',
                operation_id: 'customfield_id_put')
    end
  end

  describe 'DELETE /customfield/{id}/value/{valueId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/customfield/{id}/value/{valueId}',
                operation_id: 'customfield_id_value_id_delete')
    end
  end

  describe 'GET /customfield/{id}/value/{valueId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/customfield/{id}/value/{valueId}',
                operation_id: 'customfield_id_value_id_get')
    end
  end

  describe 'PUT /customfield/{id}/value/{valueId}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/customfield/{id}/value/{valueId}',
                operation_id: 'customfield_id_value_id_put')
    end
  end

  describe 'POST /customfield/{id}/value' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/customfield/{id}/value',
                operation_id: 'customfield_id_value_post')
    end
  end

  describe 'GET /customfield/{id}/values' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/customfield/{id}/values',
                operation_id: 'customfield_id_values_get')
    end
  end

  describe 'POST /customfield' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/customfield',
                operation_id: 'customfield_post')
    end
  end

  describe 'POST /customfields' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/customfields',
                operation_id: 'customfields_post')
    end
  end

end
