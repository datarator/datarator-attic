require_relative 'option'

module Datarator

	class OptionCopyFrom < Option
		class << self
			def name
				'from'
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
