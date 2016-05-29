require_relative 'type'
require_relative 'option_regexp_pattern'
require_relative 'option_escape'
require_relative 'options'
require 'regexp-examples'

module Datarator
  class TypeRegexp < Type
    class << self
      def name
        'regexp'
      end
    end

    def value(column)
      /#{Options.value(column.options, OptionRegexpPattern.name)}/.random_example
    end

    def nested?
      false
    end

    def escape?(column)
      val = Options.value(column.options, OptionEscape.name)
      val.nil? ? true : val
    end

    def options
      OPTIONS
    end

    # TODO: implemnent pattern validation

    OPTIONS = [
      Options.option(OptionRegexpPattern.name),
      Options.option(OptionEscape.name)
    ].freeze
  end
end
