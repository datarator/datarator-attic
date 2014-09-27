module Datarator
	class EmptyIndex

		class << self
			def indexes (overall_count, empty_percent)
				raise ArgumentError, 'empty_percent has to be integer in interval <0,100>' unless empty_percent.is_a? Integer and empty_percent.between?(0,100)
				raise ArgumentError, 'overall_count has to be integer > 0' unless overall_count.is_a? Integer and overall_count > 0

				return Set.new if empty_percent == 0

				empty_count = overall_count * empty_percent / 100

				return (1..overall_count).to_set if empty_percent == 100 or empty_count == overall_count

				if empty_percent > 50
					indexes = Set.new
					non_empty_indexes = fill_indexes(overall_count, overall_count - empty_count)
					overall_count.times do | index |
						indexes.add(index) unless non_empty_indexes.include? index
					end
				else
					indexes = fill_indexes(overall_count, empty_count)
				end

				indexes
			end

			def fill_indexes (overall_count, to_fill_count)
				result = Set.new
				to_fill_count.times {
					index = rand(overall_count) while result.include? index
					result.add(index)
				}
				result
			end

		end

		private_class_method :fill_indexes
	end
end
