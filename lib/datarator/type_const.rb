require_relative 'type.rb'
require 'faker'

module Datarator
	class TypeConst < Type

		class << self
			def name
				"const"
			end
		end

		def value(out_context)
			out_context.option[TypeConst.name]
		end

		def validate(out_context)
			raise ArgumentError.new "value not specified for const type column: #{out_context.column}" if out_context.option[TypeConst.name].nil? or out_context.option[TypeConst.name].empty?
		end

		def escape?
			true
		end

	end
end
