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

RSpec.describe 'ArticleApi' do
  describe 'DELETE /article/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/article/{id}',
        operation_id: 'article_id_delete',
        mutating:     true,
        params:       { 'id' => scratch(:article) },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'GET /article/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/article/{id}',
        operation_id: 'article_id_get',
        mutating:     false,
        params:       { 'id' => '56' },
        query:        nil,
        body:         nil,
        setup:        { method: 'POST', path: '/article' }
      )
    end
  end

  describe 'PUT /article/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/article/{id}',
        operation_id: 'article_id_put',
        mutating:     true,
        params:       { 'id' => scratch(:article) },
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'POST /article' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/article',
        operation_id: 'article_post',
        mutating:     true,
        params:       {},
        query:        nil,
        body:         JSON.parse('{"Name":"How to restart the widget service","Class":"Runbooks"}'),
        setup:        nil
      )
    end
  end

  describe 'POST /articles' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/articles',
        operation_id: 'articles_get',
        mutating:     false,
        params:       {},
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

end
