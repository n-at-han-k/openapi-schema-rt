# frozen_string_literal: true

source "https://rubygems.org"

# The conformance suite. openapi-ruby declares each operation in RSpec and
# validates what comes back against that declaration, so the document is the
# assertion and nothing is written twice. `rake openapi_ruby:generate` can
# write the document back out of the specs, which is the other direction of
# the same relationship.
gem "openapi-ruby", "~> 5.0"

# openapi-ruby's test DSL goes through rack-test, which calls an app object.
# spec/openapi_helper.rb gives it one that performs the real request against
# the RT named in .env -- nothing local, nothing stubbed.
gem "rack-test"
gem "rspec", "~> 3.13"

# The token and the URL live in .env rather than in the shell history of
# whoever ran the suite last.
gem "dotenv", "~> 3.1"
