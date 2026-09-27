# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'QueueApi' do
  describe 'DELETE /queue/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/queue/{idOrName}',
                operation_id: 'queue_id_name_delete')
    end
  end

  describe 'GET /queue/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/queue/{idOrName}',
                operation_id: 'queue_id_name_get')
    end
  end

  describe 'PUT /queue/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/queue/{idOrName}',
                operation_id: 'queue_id_name_put')
    end
  end

  describe 'POST /queue' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/queue',
                operation_id: 'queue_post')
    end
  end

  describe 'GET /queues/all' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/queues/all',
                operation_id: 'queues_all_get')
    end
  end

end
