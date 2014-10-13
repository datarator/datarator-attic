module Datarator
	class Types
		class << self
			def value(out_context)
				out_context.empty_value? ? out_context.empty_value : TYPES[out_context.type].value(out_context)
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

	require_relative 'type_const'
	require_relative 'type_row_index'
	require_relative 'type_name'
	# require_relative 'type_copy'

	TYPES = {
		#
		# specific
		#
		TypeConst.name => TypeConst.new,
		TypeRowIndex.name => TypeRowIndex.new,

		#
		# nested columns
		#
		# TypeCopy.name => TypeCopy.new,

		#
		# faker
		#

		# name
		TypeNameName.name => TypeNameName.new,
		TypeNameFirstName.name => TypeNameFirstName.new
	}
end
