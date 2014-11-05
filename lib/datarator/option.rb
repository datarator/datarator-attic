
module Datarator

	class Option
		def mandatory?
			raise NotImplementedError
		end

		def boolean?
			raise NotImplementedError
		end

		def ==(other)
			return self.class.name == other.class.name && self.mandatory? == other.mandatory? && self.boolean? == other.boolean?
		end

	end
end
