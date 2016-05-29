require_relative 'option'

module Datarator
  class OptionNumberMax < Option
    class << self
      def name
        'max'
      end
    end

    def mandatory?
      false
    end

    def boolean?
      false
    end
  end
end
