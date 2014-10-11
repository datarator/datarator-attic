module Datarator

	class Type

		def value (out_context)
			raise NotImplementedError
		end

		def escape?
			raise NotImplementedError
		end

		def validate 
			# TODO handle options validation only once per request (rather than with each and every value)
			raise NotImplementedError
		end
	end
end

