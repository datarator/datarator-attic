require_relative 'type.rb'
require_relative 'option_copy_from.rb'

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

		def nested?
			false
		end

		def from (column)
			column.out_context.columns.column_by_name(column.options[OptionCopyFrom.name])
		end

		def options
			OPTIONS
		end

		OPTIONS = [ OptionCopyFrom.new ]
	end
end
