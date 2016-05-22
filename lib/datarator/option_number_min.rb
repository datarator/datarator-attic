require_relative 'option'

module Datarator

	class OptionNumberMin < Option
		class << self
			def name
				'min'
			end
		end

		def mandatory?
			false
		end

		def boolean?
			false
		end
	end
end
