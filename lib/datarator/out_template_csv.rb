require_relative 'out_context'

module Datarator

	# deprecates liquid based solution
	# due to better performance
	class OutTemplateCsv

		def pre (out_context)
			unless out_context.options.nil? or out_context.options['header'].nil? or !out_context.options['header'].eql? 'true'
				out_context.names.join(',') + "\n"
			else
				""
			end
		end

		def item (out_context)
			values = out_context.values
			# escape character: ,
			values.map! do | value |
				value.include?(",") ? "'#{value}'" : value
			end

			values.join(',') + "\n"
			# out = Array.new
			# out_context.columns do | column |
			# 	out.push(column.value.include?(",") ? "'#{column.value}'" : column.value)
			# end
                        #
			# out.join(',') + "\n"
		end

		def post (out_context)
			''
		end

		def empty
			''
		end
	end
end
