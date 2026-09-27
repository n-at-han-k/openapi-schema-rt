# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'TicketApi' do
  describe 'DELETE /ticket/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/ticket/{id}',
                operation_id: 'ticket_id_delete')
    end
  end

  describe 'GET /ticket/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/ticket/{id}',
                operation_id: 'ticket_id_get')
    end
  end

  describe 'PUT /ticket/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/ticket/{id}',
                operation_id: 'ticket_id_put')
    end
  end

  describe 'POST /ticket' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/ticket',
                operation_id: 'ticket_post')
    end
  end

  describe 'GET /tickets' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/tickets',
                operation_id: 'tickets_get')
    end
  end

end
