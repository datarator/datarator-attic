# makes sence for liquibase to hold NULL for csv instead of ''
# see: https://github.com/seriousbusinessbe/liquibase-3.1.1_example/commit/53c9e31ca0f09e4baa501b92358a67eb57ac7f0b
require_relative 'option'

module Datarator
  class OptionEmptyValue < Option
    class << self
      def name
        'empty_value'
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
