module Datarator

	class Type

		def value
			raise NotImplementedError
		end

		def escape?
			raise NotImplementedError
		end
	end
end

