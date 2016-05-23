require_relative 'type'
require_relative 'option_number_max'
require_relative 'option_number_min'
require 'faker'

module Datarator

	class TypeNumber < Type
		class << self
			def name
				'number'
			end
		end

		def escape? (column)
			false
		end

		def nested?
			false
		end

		def options
			OPTIONS
		end

		OPTIONS = [
			Options.option(OptionNumberMax.name),
			Options.option(OptionNumberMin.name)
		]

		private
		def number (base, column)
			min = Options.value(column.options, OptionNumberMin.name)
			max = Options.value(column.options, OptionNumberMax.name)

			# min/max defaults
			min = 0 if min.nil?
			max = 10 if max.nil?

			number_in_range(base, min.to_i, max.to_i)
		end

		private
		def number_in_range (base, min, max)
			(min + rand(max-min)).to_s(base)
		end
	end

	class TypeNumberDecimal < TypeNumber

		class << self
			def name
				"#{TypeNumber.name}.decimal"
			end
		end

		def value (column)
			number(10, column)
		end
	end

	class TypeNumberHexadecimal < TypeNumber

		class << self
			def name
				"#{TypeNumber.name}.hexadecimal"
			end
		end

		def value (column)
			number(16, column)
		end
	end

	class TypeNumberBinary < TypeNumber

		class << self
			def name
				"#{TypeNumber.name}.binary"
			end
		end

		def value (column)
			number(2, column)
		end
	end

	class TypeNumberOctal < TypeNumber

		class << self
			def name
				"#{TypeNumber.name}.octal"
			end
		end

		def value (column)
			number(8, column)
		end
	end

end
