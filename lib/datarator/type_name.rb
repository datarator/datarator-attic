require_relative 'type.rb'
require 'faker'

module Datarator

	class TypeName < Type
		class << self
			def name
				'name'
			end
		end

		def escape? (column)
			true
		end

		def nested?
			false
		end
	end

	class TypeNameName < TypeName

		class << self
			def name
				"#{TypeName.name}.name"
			end
		end

		def value (column)
			Faker::Name.name
		end
	end

	class TypeNameFirstName < TypeName

		class << self
			def name
				"#{TypeName.name}.first_name"
			end
		end

		def value (column)
			Faker::Name.first_name
		end
	end

end
