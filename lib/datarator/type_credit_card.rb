require_relative 'type'
require 'faker'

module Datarator
  class TypeCreditCard < Type
    class << self
      def name
        'credit_card'
      end
    end

    def escape?(_column)
      true
    end

    def nested?
      false
    end
  end

  class TypeCreditCardNumber < TypeCreditCard
    class << self
      def name
        "#{TypeCreditCard.name}.number"
      end
    end

    def value(_column)
      Faker::Business.credit_card_number
    end
  end

  class TypeCreditCardType < TypeCreditCard
    class << self
      def name
        "#{TypeCreditCard.name}.type"
      end
    end

    def value(_column)
      Faker::Business.credit_card_type
    end
  end
end
