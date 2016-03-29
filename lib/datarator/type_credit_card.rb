require_relative 'type.rb'
require 'faker'

module Datarator

	class TypeCreditCard < Type
		class << self
			def name
				'credit_card'
			end
		end

		def escape? (column)
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

		def value (column)
			Faker::Business.credit_card_number
		end
	end

	class TypeCreditCardType < TypeCreditCard

		class << self
			def name
				"#{TypeCreditCard.name}.type"
			end
		end

		def value (column)
			Faker::Business.credit_card_type
		end
	end
end
