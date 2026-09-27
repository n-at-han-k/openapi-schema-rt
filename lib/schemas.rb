# frozen_string_literal: true
#
# openapi-ruby component classes, one per schema in the document.
#
# The specs declare responses as `schema RT.response_schema(...)`, and the
# schemas that come back carry `$ref`s into the document's components -- so
# those components have to exist as classes before openapi-ruby resolves one.
# They are built from the document here rather than written out by the
# generator: a class per schema would be 68 files saying nothing the document
# does not already say.
#
# The one transformation is the NAME. A `$ref` in the document points at
# `#/components/schemas/queueReference`, and a Ruby constant cannot be called
# that, so every component becomes `Schemas::QueueReference` and every ref
# inside every schema is repointed to match. Nothing else is touched: what
# openapi-ruby validates against is the document's own schema, keyword for
# keyword.

require "date"
require "yaml"

require "openapi_ruby"

module Schemas
  DOCUMENT = YAML.safe_load_file(
    File.expand_path("../request_tracker_rest2.yaml", __dir__),
    aliases: true, permitted_classes: [Date, Time]
  ).freeze

  COMPONENTS = (DOCUMENT.dig("components", "schemas") || {}).freeze

  module_function

  # queueReference -> QueueReference, custom-field -> CustomField.
  def constant_name(name)
    name.gsub(/[^a-zA-Z0-9]+(.)/) { Regexp.last_match(1).upcase }.sub(/\A[a-z]/, &:upcase)
  end

  # A ref points at a class now, so it has to spell the class's name.
  def rewrite_refs(node)
    case node
    when Hash
      node.each_with_object({}) do |(key, value), rewritten|
        rewritten[key] =
          if key == "$ref" && value.is_a?(String) && value.start_with?("#/components/schemas/")
            "#/components/schemas/#{constant_name(value.split("/").last)}"
          else
            rewrite_refs(value)
          end
      end
    when Array then node.map { |value| rewrite_refs(value) }
    else node
    end
  end

  def symbolize(node)
    case node
    when Hash  then node.to_h { |key, value| [key.to_sym, symbolize(value)] }
    when Array then node.map { |value| symbolize(value) }
    else node
    end
  end

  # Two passes, so a schema referring to another does not depend on the order
  # the document happens to list them in.
  COMPONENTS.each_key do |name|
    const_set(constant_name(name), Class.new do
      include OpenapiRuby::Components::Base
    end)
  end

  COMPONENTS.each do |name, schema|
    const_get(constant_name(name)).schema(symbolize(rewrite_refs(schema)))
  end
end
