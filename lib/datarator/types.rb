module Datarator
	class Types
		class << self
			def value(name)
				TYPES[name].value
			end

			def supports?(name)
				TYPES.has_key?(name)
			end

			def validate(name)
				raise "type not supported: #{name}" unless supports? name
			end

			def escape? (name)
				TYPES[name].escape?
			end
		end
	end

	require_relative 'type_name'

	TYPES = {
		# name
		TypeNameName.name => TypeNameName.new,
		TypeNameFirstName.name => TypeNameFirstName.new
	}
end
