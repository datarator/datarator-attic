module Datarator
  class EmptyIndex
    class << self
      def indexes(overall_count, empty_percent)
        raise ArgumentError, 'empty_percent has to be integer in interval <0,100>' unless empty_percent.is_a?(Integer) && empty_percent.between?(0, 100)
        raise ArgumentError, 'overall_count has to be integer > 0' unless overall_count.is_a?(Integer) && overall_count > 0

        return Set.new if empty_percent == 0
        empty_count = overall_count * empty_percent / 100

        return (0..overall_count - 1).to_set if empty_percent == 100 || empty_count == overall_count
        # idea found: http://stackoverflow.com/questions/119107/how-do-i-generate-a-list-of-n-unique-random-numbers-in-ruby
        (0..overall_count - 1).to_a.shuffle[0..empty_count - 1].to_set
      end
    end
  end
end
