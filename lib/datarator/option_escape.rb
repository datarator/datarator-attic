require_relative 'option'

module Datarator
  class OptionEscape < Option
    class << self
      def name
        'escape'
      end
    end

    def mandatory?
      false
    end

    def boolean?
      true
    end
  end
end
