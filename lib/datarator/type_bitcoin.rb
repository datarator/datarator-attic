require_relative 'type'
require 'faker'

module Datarator
  class TypeBitcoin < Type
    class << self
      def name
        'bitcoin'
      end
    end

    def escape?(_column)
      true
    end

    def nested?
      false
    end
  end

  class TypeBitcoinAddress < TypeBitcoin
    class << self
      def name
        "#{TypeBitcoin.name}.address"
      end
    end

    def value(_column)
      Faker::Bitcoin.address
    end
  end
end
