# frozen_string_literal: true
#
# What "conforming" means, and nothing about any particular endpoint.
#
# The generated files under spec/api carry everything that differs per
# operation -- which object to aim it at, what to send, what has to exist
# first -- and the generator worked all of it out from the document
# (generators/rspec/src/rtrspec/RspecCodegen.java). What is left here is the
# part that is the same every time: make the request against a real RT, check
# the status is one the document describes, and validate the body against the
# schema in that same document. Nothing is asserted twice.
#
# Point it at an RT with a .env beside this repository's root:
#
#   RT_URL=https://rt.example.com
#   RT_TOKEN=1-14-...
#   RT_MUTATE=1            # optional, see below
#
# .env is gitignored; .env.example is the template. The environment still
# wins, so a one-off run can override any of it.
#
# READ-ONLY by default. An operation that changes something is skipped unless
# RT_MUTATE=1, and when it does run it is aimed at a SCRATCH object this suite
# made -- never at anything that was in RT beforehand. bin/scrub-scratch takes
# them all down afterwards.

require 'json'
require 'net/http'
require 'uri'
require 'yaml'

require 'dotenv'
require 'json_schemer'

# Loaded before anything reads ENV below. The default is `overload: false`,
# which is the point: a variable already exported wins over the file.
Dotenv.load(File.expand_path('../.env', __dir__))

require_relative 'scratch'

module RT
  ROOT = File.expand_path('..', __dir__)

  DOC = YAML.safe_load_file(File.join(ROOT, 'request_tracker_rest2.yaml'),
                            aliases: true, permitted_classes: [Date, Time]).freeze

  SCHEMA = JSONSchemer.schema(DOC)

  URL    = ENV.fetch('RT_URL', 'https://rt.kremlin.email')
  TOKEN  = ENV.fetch('RT_TOKEN', '')
  MUTATE = ENV['RT_MUTATE'] == '1'

  BASE = URI.parse(URL + DOC.fetch('servers').first.fetch('url'))

  Response = Struct.new(:status, :body, :raw)

  module_function

  # The one thing every generated example calls. Everything it is given was
  # decided by the generator from the document.
  def verify(example:, method:, path:, operation_id:, mutating:, params:, query:, body:, setup: nil)
    return example.skip('RT_TOKEN is not set; nothing to talk to') if TOKEN.empty?

    operation = DOC.dig('paths', path, method.downcase)
    return example.skip("#{method} #{path} is not in the document") unless operation

    if mutating && !MUTATE
      return example.skip("#{method} changes state; set RT_MUTATE=1 to include it")
    end

    missing = params.select { |_, value| value.nil? }.keys
    return example.skip("nothing safe to aim #{method} #{path} at: #{missing.join(', ')}") if missing.any?

    target = path.gsub(/\{(\w+)\}/) { URI.encode_www_form_component(params.fetch(Regexp.last_match(1)).to_s) }

    # What the document says has to happen first, if anything.
    call(setup[:method], interpolate(setup[:path], params), body: grant_body(params)) if setup

    response = call(method, target, body: body, query: query)

    # A 5xx is never conforming, whatever the document says about it. RT
    # answers one to a delete it has already done, and describing that as a
    # legitimate response means every Internal Server Error passes -- which is
    # how an endpoint that does not work at all sat here being tested.
    if response.status.start_with?('5')
      raise "#{method} #{path} answered #{response.status}: #{response.raw[0, 200]}"
    end

    declared = operation.fetch('responses').keys.map(&:to_s)
    unless declared.include?(response.status) || declared.include?('default')
      raise "#{method} #{path} answered #{response.status}, which the document does not " \
            "describe (it describes #{declared.join(', ')}). Body: #{response.raw[0, 300]}"
    end

    Scratch.forget_by_value(params.values) if mutating && method == 'DELETE' && response.status.start_with?('2')

    schema = operation.dig('responses', response.status, 'content', 'application/json', 'schema')
    return if schema.nil? || response.body.nil?

    pointer = "#/paths/#{escape(path)}/#{method.downcase}/responses/#{response.status}" \
              '/content/application~1json/schema'
    errors = SCHEMA.ref(pointer).validate(response.body).to_a

    return if errors.empty?

    raise "#{method} #{path} answered #{response.status} with a body the document does not " \
          "describe:\n" + errors.first(8).map { |e| report(e) }.join("\n")
  end

  # A setup request reuses the target's own parameters: the document links the
  # two, so they address the same thing.
  def interpolate(path, params)
    path.gsub(/\{(\w+)\}/) { URI.encode_www_form_component(params.fetch(Regexp.last_match(1), '').to_s) }
  end

  # The setup request's body, built from the parameters the link shares with
  # the target. `right` and a principal is the only shape a link declares.
  def grant_body(params)
    return nil unless params.key?('right')

    { 'Right' => params['right'],
      params.key?('principalId') && params['principalId'] ? 'Group' : nil => params['principalId'] }
      .compact
  end

  def call(method, target, body: nil, query: nil)
    uri = URI.parse(BASE.to_s + target)
    uri.query = query if query

    request = Net::HTTP.const_get(method.capitalize).new(uri)
    request['Authorization'] = "token #{TOKEN}"
    request['Accept'] = 'application/json'

    unless body.nil?
      request['Content-Type'] = 'application/json'
      request.body = JSON.dump(body)
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

# What a generated spec calls for a parameter it must not aim at real data.
# The kinds come from the generator; the making and the removing are here.
def scratch(kind)
  RT::Scratch.fetch(kind.to_s)
end

def scratch_value
  RT::Scratch.fetch_value
end

def unique(prefix)
  RT::Scratch.name(prefix)
end

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.formatter = :documentation if ENV['RT_TOKEN']

  # Whatever the mutating half made, taken back down -- even if it failed, and
  # including what the create examples made, which nothing tracked. By name
  # rather than by a list of ids, because a run that dies halfway leaves no
  # list.
  config.after(:suite) do
    if ENV['RT_MUTATE'] == '1'
      system(File.expand_path('../bin/scrub-scratch', __dir__), '--force', out: File::NULL)
    end
  end
end
