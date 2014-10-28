require_relative 'type.rb'

module Datarator
	class TypeConst < Type

		class << self
			def name
				"const"
			end
		end

		def value(column)
			column.options['value']
		end

		# def validate(out_context, column)
		# 	raise ArgumentError.new "value not specified for const type column: #{out_context.column}" if out_context.option['value'].nil? or out_context.option['value'].empty?
		# end

		def escape? (column)
			true
		end

		def nested? (column)
			false
		end
	end
end
