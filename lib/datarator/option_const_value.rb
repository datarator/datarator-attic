require_relative 'option.rb'

module Datarator

	class OptionConstValue < Option
		class << self
			def name
				'value'
			end
		end

		def mandatory?
			true
		end

		def boolean?
			false
		end
	end
end
