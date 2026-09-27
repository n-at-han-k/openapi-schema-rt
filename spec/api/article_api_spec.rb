# frozen_string_literal: true
#
# GENERATED from request_tracker_rest2.yaml by bin/generate-specs. Do not edit.
#
# One example per operation the document describes. The example says WHICH
# operation; spec_helper.rb says what conforming means -- it reads this same
# document at runtime, so the schema in it is the assertion and nothing here
# restates it.

require 'spec_helper'

RSpec.describe 'ArticleApi' do
  describe 'DELETE /article/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'DELETE', path: '/article/{id}',
                operation_id: 'article_id_delete')
    end
  end

  describe 'GET /article/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'GET', path: '/article/{id}',
                operation_id: 'article_id_get')
    end
  end

  describe 'PUT /article/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'PUT', path: '/article/{id}',
                operation_id: 'article_id_put')
    end
  end

  describe 'POST /article' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/article',
                operation_id: 'article_post')
    end
  end

  describe 'POST /articles' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(example: self, method: 'POST', path: '/articles',
                operation_id: 'articles_get')
    end
  end

end
