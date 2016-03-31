require_relative 'option'

module Datarator

	class OptionRegexpPattern < Option
		class << self
			def name
				'pattern'
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
