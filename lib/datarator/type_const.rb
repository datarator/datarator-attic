require_relative 'type'
require_relative 'option_const_value'
require_relative 'options'

module Datarator
  class TypeConst < Type
    class << self
      def name
        'const'
      end
    end

    def value(column)
      Options.value(column.options, OptionConstValue.name)
    end

    def escape?(_column)
      true
    end

    def nested?
      false
    end

    def options
      OPTIONS
    end

    OPTIONS = [Options.option(OptionConstValue.name)].freeze
  end
end
