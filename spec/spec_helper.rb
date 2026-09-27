# frozen_string_literal: true
#
# What "conforming" means. The generated files under spec/api say only WHICH
# operations exist; everything here reads the document at runtime, so the
# schema in request_tracker_rest2.yaml is the assertion and no expectation is
# ever written twice.
#
# Point it at a real RT:
#
#   RT_TOKEN=1-14-... bundle exec rspec
#   RT_URL=https://rt.example.com RT_TOKEN=... bundle exec rspec
#
# READ-ONLY by default. An operation that changes something -- a PUT, a
# DELETE, or a POST the document says answers 201 -- is skipped unless
# RT_MUTATE=1, because the obvious way to test a create is to leave one
# behind on every run.

require 'json'
require 'net/http'
require 'uri'
require 'yaml'

require 'json_schemer'

module RT
  ROOT = File.expand_path('..', __dir__)

  DOC = YAML.safe_load_file(File.join(ROOT, 'request_tracker_rest2.yaml'),
                            aliases: true, permitted_classes: [Date, Time]).freeze
  FIXTURES = YAML.safe_load_file(File.join(__dir__, 'fixtures.yml')).freeze

  SCHEMA = JSONSchemer.schema(DOC)

  URL    = ENV.fetch('RT_URL', 'https://rt.kremlin.email')
  TOKEN  = ENV.fetch('RT_TOKEN', '')
  MUTATE = ENV['RT_MUTATE'] == '1'

  BASE = URI.parse(URL + DOC.fetch('servers').first.fetch('url'))

  Response = Struct.new(:status, :body, :raw)

  module_function

  # The one thing every generated example calls.
  def verify(example:, method:, path:, operation_id:)
    return example.skip('RT_TOKEN is not set; nothing to talk to') if TOKEN.empty?

    operation = DOC.dig('paths', path, method.downcase)
    return example.skip("#{method} #{path} is not in the document") unless operation

    if mutating?(method, operation) && !MUTATE
      return example.skip("#{method} changes state; set RT_MUTATE=1 to include it")
    end

    fixture = FIXTURES.fetch('paths', {}).fetch(path, {}) || {}

    begin
      target = fill(path, fixture)
    rescue MissingFixture => e
      return example.skip(e.message)
    end

    response = call(method, target, fixture)

    declared = operation.fetch('responses').keys.map(&:to_s)
    unless declared.include?(response.status) || declared.include?('default')
      raise "#{method} #{path} answered #{response.status}, which the document does not " \
            "describe (it describes #{declared.join(', ')}). Body: #{response.raw[0, 300]}"
    end

    schema = operation.dig('responses', response.status, 'content', 'application/json', 'schema')
    # A response the document describes without a body, or by $ref to a shared
    # one, is checked for its status and nothing more.
    return if schema.nil? || response.body.nil?

    pointer = "#/paths/#{escape(path)}/#{method.downcase}/responses/#{response.status}" \
              '/content/application~1json/schema'
    errors = SCHEMA.ref(pointer).validate(response.body).to_a

    return if errors.empty?

    raise "#{method} #{path} answered #{response.status} with a body the document does not " \
          "describe:\n" + errors.first(8).map { |e| report(e) }.join("\n")
  end

  # A create, an update or a delete. A POST is only a create when the document
  # says it answers 201 -- RT searches with POST too, and those are reads.
  def mutating?(method, operation)
    return true if %w[PUT PATCH DELETE].include?(method)

    method == 'POST' && operation.fetch('responses', {}).key?('201')
  end

  MissingFixture = Class.new(StandardError)

  # Path parameters come from spec/fixtures.yml: this suite talks to a real
  # RT, and only the person running it knows which ticket is safe to read.
  def fill(path, fixture)
    params = FIXTURES.fetch('params', {}).merge(fixture.fetch('params', {}) || {})

    path.gsub(/\{(\w+)\}/) do
      name = Regexp.last_match(1)
      value = params[name]
      raise(MissingFixture, "no fixture for {#{name}} in #{path}") if value.nil?

      URI.encode_www_form_component(value.to_s)
    end
  end

  def call(method, target, fixture)
    uri = URI.parse(BASE.to_s + target)
    uri.query = fixture['query'] if fixture['query']

    request = Net::HTTP.const_get(method.capitalize).new(uri)
    request['Authorization'] = "token #{TOKEN}"
    request['Accept'] = 'application/json'

    if fixture.key?('body')
      request['Content-Type'] = 'application/json'
      request.body = JSON.dump(fixture['body'])
    end

    raw = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http|
      http.request(request)
    }

    Response.new(raw.code, parse(raw.body), raw.body.to_s)
  end

  def parse(body)
    return nil if body.nil? || body.strip.empty?

    JSON.parse(body)
  rescue JSON::ParserError
    nil
  end

  def report(error)
    "  #{error['data_pointer'].empty? ? '(root)' : error['data_pointer']}: " \
      "#{error['type']} -- got #{error['data'].inspect[0, 60]}"
  end

  # A JSON pointer inside a URI fragment: `/` is ~1, and RT's paths carry
  # braces, which URI.join will not have.
  def escape(path)
    path.gsub('~', '~0').gsub('/', '~1').gsub('{', '%7B').gsub('}', '%7D')
  end
end

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.formatter = :documentation if ENV['RT_TOKEN']
end
