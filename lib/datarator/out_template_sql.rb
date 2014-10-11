require_relative 'out_context'

module Datarator

	# deprecates liquid based solution
	# due to better performance
	class OutTemplateSql

		def pre (out_context)
			''
		end

		def item (out_context)
			values = out_context.columns.map.with_index do | column, idx |

				# escaping character: '
				if column.value.is_a?(String)
					column.value = column.value.gsub(/'/, "''")
				end

				# escaping values that need escaping based on type
				if column.escape
					column.value = "'#{column.value}'"
				end

				column.value
			end

			"INSERT INTO #{out_context.document} (#{out_context.names.join(',')}) values (#{values.join(',')});\n"
		end

		def post (out_context)
			''
		end

		def empty
			'NULL'
		end
	end
end
