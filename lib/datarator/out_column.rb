require_relative 'in_column'

module Datarator

	class OutColumn < InColumn

		attr_accessor :value, :escape

	end
end
