require_relative 'type.rb'

module Datarator

	class TypeCopy < Type

		class << self
			def name
				'copy'
			end
		end

		def value (column)
			(from column).last_value
		end

		# def validate(out_context, column)
		# end

		def escape? (column)
			Types.escape? from column
		end

		def nested? (column)
			Types.nested? from column
		end

		def from (column)
			column.out_context.columns.column_by_name(column.options['from'])
		end
	end
end
