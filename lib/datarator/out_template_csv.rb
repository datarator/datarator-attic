require_relative 'out_template'
require_relative 'out_context'
require_relative 'option_header'

module Datarator

	class OutTemplateCsv < OutTemplate

		def pre (out_context)
			if Options.value(out_context.options, OptionHeader.name)
				(out_context.columns.map_shallow() { | column | column.name }).join(',') + "\n"
			else
				''
			end 
			# unless out_context.options.nil? or out_context.options['header'].nil? or !out_context.options['header'].eql? 'true'
			# 	(out_context.columns.map_shallow() { | column | column.name }).join(',') + "\n"
			# else
			# 	""
			# end
		end

		def item (out_context)
			(
				out_context.columns.map_shallow() do | column |
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

		def content_type
			'csv/plain'
		end

		def file_ext
			'csv'
		end

		def options
			OPTIONS
		end

		OPTIONS = [ OptionHeader.new ]
	end
end
