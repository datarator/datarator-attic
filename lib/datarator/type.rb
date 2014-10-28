module Datarator

	class Type

		def value (column)
			raise NotImplementedError
		end

		def escape? (column)
			raise NotImplementedError
		end

		# def validate(column)
		# 	raise NotImplementedError
		# end

		def nested? (column)
			raise NotImplementedError
		end
	end
end

