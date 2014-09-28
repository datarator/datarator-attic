module Datarator
	class EmptyIndex

		class << self
			def indexes (overall_count, empty_percent)
				raise ArgumentError, 'empty_percent has to be integer in interval <0,100>' unless empty_percent.is_a? Integer and empty_percent.between?(0,100)
				raise ArgumentError, 'overall_count has to be integer > 0' unless overall_count.is_a? Integer and overall_count > 0

				return Set.new if empty_percent == 0
				empty_count = overall_count * empty_percent / 100

				return (1..overall_count).to_set if empty_percent == 100 or empty_count == overall_count
				# idea found: http://stackoverflow.com/questions/119107/how-do-i-generate-a-list-of-n-unique-random-numbers-in-ruby 
				(1..overall_count).to_a.shuffle[0..empty_count-1].to_set
			end

		end

	end
end
