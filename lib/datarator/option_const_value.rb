require_relative 'option'

module Datarator
  class OptionConstValue < Option
    class << self
      def name
        'value'
      end
    end

    def mandatory?
      true
    end

    def boolean?
      false
    end
  end
end
