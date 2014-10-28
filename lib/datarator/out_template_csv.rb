require_relative 'out_context'

module Datarator

	class OutTemplateCsv

		def pre (out_context)
			unless out_context.options.nil? or out_context.options['header'].nil? or !out_context.options['header'].eql? 'true'
				(out_context.columns.map_shallow([]) { | column, args | column.name }).join(',') + "\n"
			else
				""
			end
		end

		def item (out_context)
			(
				out_context.columns.map_shallow([ out_context ]) do | column, args | 
					value = column.value
					# escape character: ,
					value.include?(",") ? "'#{value}'" : value
				end
			).join(',') + "\n"
		end

		def post (out_context)
			''
		end

		def empty (out_context)
			''
		end
	end
end
