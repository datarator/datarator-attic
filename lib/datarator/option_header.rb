require_relative 'option.rb'

module Datarator

	class OptionHeader < Option
		class << self
			def name
				'header'
			end
		end

		def mandatory?
			false
		end

		def boolean?
			true
		end
	end
end
