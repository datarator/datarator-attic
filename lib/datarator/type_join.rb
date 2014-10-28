require_relative 'type.rb'

module Datarator

	class TypeJoin < Type
		class << self
			def name
				'join'
			end
		end

		def escape? (column)
			true
		end

		def value (column)
			(
				column.nested.map do | nested |
					nested.value
				end
			).join(separator column)
		end

		def nested? (column)
			true
		end

		def separator (column)
			return '' if column.options.nil?
			separator = column.options['separator']
			separator.nil? ? "" : separator
		end

	end
end
