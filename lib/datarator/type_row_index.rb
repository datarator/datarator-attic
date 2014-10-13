require_relative 'type.rb'

module Datarator
	class TypeRowIndex < Type

		class << self
			def name
				"row_index"
			end
		end

		def value(out_context)
			out_context.row_index
		end

		def escape?
			false
		end

	end
end
