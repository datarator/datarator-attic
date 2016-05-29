require_relative 'option'

module Datarator
  class OptionLiquibaseChangeset < Option
    class << self
      def name
        'changeset'
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
