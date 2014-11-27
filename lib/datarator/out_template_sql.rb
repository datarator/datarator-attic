require_relative 'out_template'
require_relative 'out_context'

module Datarator

	class OutTemplateSql < OutTemplate

		def pre (out_context)
			''
		end

		def item (out_context)
			# TODO cache! (somewhere in context probably)
			names = (out_context.columns.map_shallow() { | column | column.name })

			values = (
				out_context.columns.map_shallow() do | column |
					value = column.value

					# escaping character: '
					value = value.gsub(/'/, "''") if value.is_a? String

					# escaping values that need escaping based on type
					value = "'#{value}'" if column.escape

					value
				end
			)

			"INSERT INTO #{out_context.document} (#{names.join(',')}) values (#{values.join(',')});\n"
		end

		def post (out_context)
			''
		end

		def empty (out_context)
			'NULL'
		end

		def content_type
			'text/plain'
		end

		def file_ext
			'sql'
		end

	end
end
