require_relative 'type'
require_relative 'option_separator'

module Datarator
  class TypeJoin < Type
    class << self
      def name
        'join'
      end
    end

    def escape?(_column)
      true
    end

    def value(column)
      column.nested.map(&:value)
            .join(separator(column))
    end

    def nested?
      true
    end

    def separator(column)
      separator = column.options[OptionSeparator.name]
      separator.nil? ? '' : separator
    end

    def options
      OPTIONS
    end

    OPTIONS = [OptionSeparator.new].freeze
  end
end
