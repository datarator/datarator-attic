module Datarator
	class Types
		class << self
			def value(column)
				column.empty_index? ? column.out_context.empty_value : TYPES[column.type].value(column)
			end

			def supports?(name)
				TYPES.has_key?(name)
			end

			def validate(type)
				raise ArgumentError, 'type can\'t be empty' if type.nil? or type.empty?
				raise ArgumentError, "type not supported: #{type}" unless supports? type
			end

			def nested? (column)
				TYPES[column.type].nested? column
			end

			def escape? (column)
				TYPES[column.type].escape? column
			end
		end
	end

	require_relative 'type_const'
	require_relative 'type_row_index'
	require_relative 'type_copy'

	require_relative 'type_list'
	require_relative 'type_join'

	require_relative 'type_name'

	TYPES = {

		#
		# specific
		#
		TypeConst.name => TypeConst.new,
		TypeRowIndex.name => TypeRowIndex.new,
		TypeCopy.name => TypeCopy.new,

		#
		# nested columns
		#
		TypeListSeq.name => TypeListSeq.new,
		TypeListRand.name => TypeListRand.new,
		TypeJoin.name => TypeJoin.new,

		#
		# faker
		#

		# name
		TypeNameName.name => TypeNameName.new,
		TypeNameFirstName.name => TypeNameFirstName.new
	}
end
