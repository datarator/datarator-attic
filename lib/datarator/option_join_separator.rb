require_relative 'option.rb'

module Datarator

	class OptionJoinSeparator < Option
		class << self
			def name
				'separator'
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
