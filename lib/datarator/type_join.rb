require_relative 'type.rb'
require_relative 'option_separator.rb'

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

		def nested?
			true
		end

		def separator (column)
			separator = column.options[OptionSeparator.name]
			separator.nil? ? '' : separator
		end

		def options
			OPTIONS
		end

		OPTIONS = [ OptionSeparator.new ]
	end
end
