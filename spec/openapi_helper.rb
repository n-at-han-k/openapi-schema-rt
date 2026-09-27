# frozen_string_literal: true
#
# The suite's wiring, and nothing about any particular endpoint.
#
# Every generated file under spec/api declares its operations in
# openapi-ruby's DSL and calls run_test!, which validates what comes back
# against that declaration. The declarations are written by the generator from
# request_tracker_rest2.yaml, so the document is the assertion and nothing is
# stated twice.
#
#   RT_URL=https://rt.example.com
#   RT_TOKEN=1-14-...
#   RT_MUTATE=1            # or bin/test --mutate
#
# .env is gitignored; .env.example is the template. The environment wins over
# the file, so a one-off run can override any of it.

require "json"
require "net/http"
require "uri"

require "dotenv"

Dotenv.load(File.expand_path("../.env", __dir__))

require "openapi_ruby"
require "openapi_ruby/rspec"

require_relative "../lib/schemas"
require_relative "scratch"

module RT
  # The document, for the generated specs to declare from. Every lookup here
  # is generic -- a path, a method, a status -- and the specs supply those.
  DOC = Schemas::DOCUMENT

  module_function

  # The schema of a path or query parameter, as the document declares it.
  def parameter_schema(path, name)
    declared = (DOC.dig("paths", path, "parameters") || []) +
               VERBS.flat_map { |verb| DOC.dig("paths", path, verb, "parameters") || [] }

    found = declared.map { |parameter| resolve(parameter) }
                    .find { |parameter| parameter["name"] == name }

    Schemas.symbolize(Schemas.rewrite_refs(found&.fetch("schema", nil) || { "type" => "string" }))
  end

  # The request schema of one operation.
  def body_schema(path, method)
    schema = DOC.dig("paths", path, method.downcase, "requestBody", "content",
                     "application/json", "schema")

    Schemas.symbolize(Schemas.rewrite_refs(schema || {}))
  end

  # The schema of one response of one operation.
  def response_schema(path, method, code)
    schema = DOC.dig("paths", path, method.downcase, "responses", code, "content",
                     "application/json", "schema")

    Schemas.symbolize(Schemas.rewrite_refs(schema || {}))
  end

  # A shared parameter or response is declared once and referred to; a lookup
  # has to follow that.
  def resolve(node)
    ref = node["$ref"]
    return node unless ref

    ref.sub("#/", "").split("/").reduce(DOC) { |document, step| document.fetch(step) }
  end

  VERBS = %w[get put post delete patch].freeze
end

module RT
  URL      = ENV.fetch("RT_URL", "https://rt.kremlin.email")
  TOKEN    = ENV.fetch("RT_TOKEN", "")
  USER     = ENV.fetch("RT_USER", "")
  PASSWORD = ENV.fetch("RT_PASSWORD", "")
  MUTATE   = ENV["RT_MUTATE"] == "1"

  # openapi-ruby's test DSL goes through rack-test, which calls an app object
  # rather than opening a socket. This is that object, and all it does is
  # perform the request it was handed against the RT in .env: same method,
  # same path, same body, plus the token. Nothing is served locally and
  # nothing is stubbed -- every example in this suite is answered by
  # rt.kremlin.email.
  class LiveRT
    def call(env)
      request = build(env)

      response = Net::HTTP.start(uri(env).hostname, uri(env).port,
                                 use_ssl: uri(env).scheme == "https") { |http|
        http.request(request)
      }

      [response.code.to_i,
       { "content-type" => response["content-type"].to_s },
       [response.body.to_s]]
    end

    private

    def uri(env)
      @uri ||= begin
        path = env.fetch("PATH_INFO")
        query = env["QUERY_STRING"].to_s

        URI.parse(URL + path + (query.empty? ? "" : "?#{query}"))
      end
    end

    def build(env)
      method = env.fetch("REQUEST_METHOD").capitalize
      request = Net::HTTP.const_get(method).new(uri(env))

      # A token where there is one. The RT in docker-compose.yml has no
      # tokens yet -- they are made in the UI -- so a username and password
      # are accepted too, which is the other scheme this document describes.
      if TOKEN.empty?
        request.basic_auth(USER, PASSWORD)
      else
        request["Authorization"] = "token #{TOKEN}"
      end

      request["Accept"] = "application/json"

      body = env["rack.input"]&.read.to_s
      unless body.empty?
        request["Content-Type"] = env.fetch("CONTENT_TYPE", "application/json")
        request.body = body
      end

      request
    end
  end
end

OpenapiRuby.configure do |config|
  config.schemas = {
    request_tracker_rest2: {
      openapi_version: "3.1.0",
      info: { title: "Request Tracker REST2", version: "0.3.3" },
      servers: [{ url: "/REST/2.0" }],
      prefix: "/REST/2.0"
    }
  }

  # RT spells its fields the way it spells them -- Name, SubjectTag, _url --
  # and a document that renamed them would describe a different API.
  config.camelize_keys = false

  config.component_paths = ["lib"]

  # The middleware is for an app that serves the API. RT serves this one.
  config.request_validation = :disabled
  config.response_validation = :disabled
end

RSpec.configure do |config|
  config.disable_monkey_patching!

  # Every request in every example goes here.
  config.define_derived_metadata(type: :openapi) do |metadata|
    metadata[:app] = RT::LiveRT.new
  end

  config.include(Module.new do
    def app
      RT::LiveRT.new
    end
  end, type: :openapi)

  config.before(:suite) do
    if RT::TOKEN.empty? && RT::USER.empty?
      raise "no credentials: set RT_TOKEN, or RT_USER and RT_PASSWORD. See .env.example"
    end
  end

  # Whatever the mutating half made, taken back down -- even if it failed, and
  # including what the create examples made. By name rather than by a list of
  # ids, because a run that dies halfway leaves no list.
  config.after(:suite) do
    if RT::MUTATE
      system(File.expand_path("../bin/scrub-scratch", __dir__), "--force", out: File::NULL)
    end
  end
end
