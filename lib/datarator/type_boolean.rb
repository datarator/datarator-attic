require_relative 'type'
require 'faker'

module Datarator
  class TypeBoolean < Type
    class << self
      def name
        'boolean'
      end
    end

    def escape?(_column)
      false
    end

    def nested?
      false
    end

    def value(column)
      true_ratio = Options.value(column.options, OptionBooleanTrueRatio.name).to_f

      if true_ratio.nil?
        Faker::Boolean.boolean
      else
        Faker::Boolean.boolean true_ratio
      end
    end

    def options
      OPTIONS
    end

    OPTIONS = [
      Options.option(OptionBooleanTrueRatio.name)
    ].freeze
  end
end
