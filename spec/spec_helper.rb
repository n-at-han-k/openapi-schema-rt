# frozen_string_literal: true
#
# What "conforming" means. The generated files under spec/api say only WHICH
# operations exist; everything here reads the document at runtime, so the
# schema in request_tracker_rest2.yaml is the assertion and no expectation is
# ever written twice.
#
# Point it at a real RT with a .env beside this repository's root:
#
#   RT_URL=https://rt.example.com
#   RT_TOKEN=1-14-...
#   RT_MUTATE=1            # optional, see below
#
# .env is gitignored; .env.example is the template. The environment still
# wins, so a one-off run can override any of it.
#
# READ-ONLY by default. An operation that changes something -- a PUT, a
# DELETE, or a POST the document says answers 201 -- is skipped unless
# RT_MUTATE=1, because the obvious way to test a create is to leave one
# behind on every run.

require 'json'
require 'net/http'
require 'uri'
require 'yaml'

require 'dotenv'
require 'json_schemer'

# Loaded before anything reads ENV below. `overload: false` is the default
# and the point: a variable already exported wins over the file.
Dotenv.load(File.expand_path('../.env', __dir__))

require_relative 'scratch'

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
    changing = mutating?(method, operation)

    begin
      target = changing ? fill_scratch(path, method) : fill(path, fixture)
      fixture = fixture.merge('body' => body_for(path, method)) if changing && needs_body?(operation)
    rescue MissingFixture => e
      return example.skip(e.message)
    end

    response = call(method, target, fixture)

    declared = operation.fetch('responses').keys.map(&:to_s)
    unless declared.include?(response.status) || declared.include?('default')
      raise "#{method} #{path} answered #{response.status}, which the document does not " \
            "describe (it describes #{declared.join(', ')}). Body: #{response.raw[0, 300]}"
    end

    Scratch.forget(subject_of(path)) if changing && method == 'DELETE' && response.status.start_with?('2')

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

  # Which kind of object a path is about, from its first literal segment.
  # /queue/{idOrName}/rights/... is about a queue.
  def subject_of(path)
    segment = path.split('/').reject(&:empty?).first.to_s

    Scratch::RECIPES.key?(segment) ? segment : segment.sub(/s\z/, '')
  end

  # A mutating operation is aimed at something this run made. Nothing here
  # ever touches an object that was in RT before the suite started.
  def fill_scratch(path, method)
    subject = subject_of(path)

    path.gsub(/\{(\w+)\}/) do
      case Regexp.last_match(1)
      when 'valueId'     then Scratch.fetch_value
      when 'principalId' then Scratch.fetch('group')
      when 'groupId'     then Scratch.fetch('group')
      when 'right'       then 'SeeQueue'
      else
        unless Scratch::RECIPES.key?(subject)
          raise(MissingFixture, "nothing safe to aim #{method} #{path} at: no scratch #{subject}")
        end

        Scratch.fetch(subject)
      end
    end
  end

  def needs_body?(operation)
    operation.key?('requestBody')
  end

  # The smallest body the document says is acceptable, built from the schema's
  # own required fields and examples rather than from a table of guesses.
  def body_for(path, method)
    fixture = FIXTURES.fetch('bodies', {})["#{method} #{path}"]
    raise(MissingFixture, "no body fixture for #{method} #{path}") if fixture.nil?

    resolve(fixture)
  end

  # %{queue} and friends are whatever spec/scratch.rb made for this run. A
  # body cannot name a real object even by mistake, because nothing but these
  # placeholders is substituted.
  def resolve(node)
    case node
    when Hash  then node.transform_values { |value| resolve(value) }
    when Array then node.map { |value| resolve(value) }
    when String
      node.gsub(/%\{(\w+)\}/) do
        key = Regexp.last_match(1)
        case key
        when 'run'    then Scratch::RUN
        when 'serial' then Scratch.serial
        else Scratch.fetch(key)
        end
      end
    else node
    end
  end

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

  def call(method, target, fixture = {})
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

  # Whatever the mutating half made, taken back down -- even if it failed,
  # and including what the CREATE examples made, which Scratch never saw. By
  # name rather than by a list of ids, because a run that dies halfway leaves
  # no list.
  config.after(:suite) do
    if ENV['RT_MUTATE'] == '1'
      system(File.expand_path('../bin/scrub-scratch', __dir__), '--force', out: File::NULL)
    end
  end
  config.formatter = :documentation if ENV['RT_TOKEN']
end
