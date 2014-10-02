require 'datarator/out_context'

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
			# escape character: ,
			out_context.values.map! do | value |
				value.include?(",") ? "'#{value}'" : value
			end

			out_context.values.join(',') + "\n"
		end

		def post (out_context)
			''
		end

		def empty (out_context)
			''
		end
	end
end
