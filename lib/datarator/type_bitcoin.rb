require_relative 'type.rb'
require 'faker'

module Datarator

	class Bitcoin < Type
		class << self
			def name
				'bitcoin'
			end
		end

		def escape? (column)
			true
		end

		def nested?
			false
		end
	end

	class BitcoinAddress < Bitcoin

		class << self
			def name
				"#{Bitcoin.name}.address"
			end
		end

		def value (column)
			Faker::Bitcoin.address
		end
	end
end
