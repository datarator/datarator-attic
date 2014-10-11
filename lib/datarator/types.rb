module Datarator
	class Types
		class << self
			def value(out_context)
				if out_context.empty_indexes[out_context.current_name].include? out_context.row_index
					out_context.empty_value
				else
					TYPES[out_context.current_type].value out_context
				end
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
	# require_relative 'type_copy'

	TYPES = {
		# specific
		# TypeCopy.name => TypeCopy.new,

		#
		# faker
		#

		# name
		TypeNameName.name => TypeNameName.new,
		TypeNameFirstName.name => TypeNameFirstName.new
	}
end
