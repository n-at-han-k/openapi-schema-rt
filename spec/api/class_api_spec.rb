# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'ClassApi' do
  describe 'DELETE /class/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/class/{idOrName}',
                operation_id: 'class_id_name_delete')
    end
  end

  describe 'GET /class/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/class/{idOrName}',
                operation_id: 'class_id_name_get')
    end
  end

  describe 'PUT /class/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/class/{idOrName}',
                operation_id: 'class_id_name_put')
    end
  end

  describe 'POST /class' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/class',
                operation_id: 'class_post')
    end
  end

  describe 'GET /classes/all' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/classes/all',
                operation_id: 'classes_all_get')
    end
  end

end
