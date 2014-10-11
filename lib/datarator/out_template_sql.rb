require_relative 'out_context'

module Datarator

	# deprecates liquid based solution
	# due to better performance
	class OutTemplateSql

		def pre (out_context)
			''
		end

		def item (out_context)
			# escaping character: '
			out_context.values.map! do | value |
				value.is_a?(String) ? value.gsub(/'/, "''") : value
			end

			# escaping values that need escaping based on type
			out_context.values.map!.with_index do | value, idx |
				out_context.escapes[idx] ? "'#{value}'" : value
			end

			"INSERT INTO #{out_context.document} (#{out_context.names.join(',')}) values (#{out_context.values.join(',')});\n"
		end

		def post (out_context)
			''
		end

		def empty
			'NULL'
		end
	end
end
