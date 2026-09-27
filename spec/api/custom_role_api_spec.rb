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

RSpec.describe 'CustomRoleApi' do
  describe 'GET /customrole/{id}' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'GET',
        path:         '/customrole/{id}',
        operation_id: 'customrole_id_get',
        mutating:     false,
        params:       { 'id' => '56' },
        query:        nil,
        body:         nil,
        setup:        nil
      )
    end
  end

  describe 'POST /customroles' do
    it 'answers a documented status, with a body matching the schema' do
      RT.verify(
        example:      self,
        method:       'POST',
        path:         '/customroles',
        operation_id: 'customroles_get',
        mutating:     false,
        params:       {},
        query:        nil,
        body:         {},
        setup:        nil
      )
    end
  end

end
