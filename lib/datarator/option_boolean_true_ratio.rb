require_relative 'option'

module Datarator
  class OptionBooleanTrueRatio < Option
    class << self
      def name
        'true_ratio'
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
