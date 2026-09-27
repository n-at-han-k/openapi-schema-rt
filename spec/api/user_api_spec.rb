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

RSpec.describe 'UserApi' do
  describe 'DELETE /user/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'DELETE',
        path:         '/user/{idOrName}',
        operation_id: 'user_id_name_delete',
        mutating:     true,
        params:       { 'idOrName' => scratch(:user) },
        query:        nil,
        body:         nil,
        setup:        { method: 'GET', path: '/user/{idOrName}' }
      )
    end
  end

  describe 'GET /user/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/user/{idOrName}',
        operation_id: 'user_id_name_get',
        mutating:     false,
        params:       { 'idOrName' => nil },
        query:        nil,
        body:         nil,
        setup:        { method: 'POST', path: '/user' }
      )
    end
  end

  describe 'PUT /user/{idOrName}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'PUT',
        path:         '/user/{idOrName}',
        operation_id: 'user_id_name_put',
        mutating:     true,
        params:       { 'idOrName' => scratch(:user) },
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

  describe 'POST /user' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/user',
        operation_id: 'user_post',
        mutating:     true,
        params:       {},
        query:        nil,
        body:         JSON.parse('{"Name":"NewUser","Privileged":1,"Password":"Color Out of Space is an intriguing story by Lovecraft."}'),
        setup:        nil
      )
    end
  end

  describe 'POST /users' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/users',
        operation_id: 'users_get',
        mutating:     false,
        params:       {},
        query:        nil,
        body:         JSON.parse('[{"field":"Name","value":"userid","operator":"LIKE"}]'),
        setup:        nil
      )
    end
  end

end
