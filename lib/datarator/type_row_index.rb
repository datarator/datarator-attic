require_relative 'type.rb'

module Datarator
	class TypeRowIndex < Type

		class << self
			def name
				"row_index"
			end
		end

		def value (column)
			column.out_context.row_index
		end

		def escape? (column)
			false
		end

		def nested?
			false
		end
	end
end
