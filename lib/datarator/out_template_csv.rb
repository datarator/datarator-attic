require_relative 'out_template'
require_relative 'out_context'
require_relative 'option_header'
require_relative 'option_empty_value'

module Datarator

	class OutTemplateCsv < OutTemplate

		class << self
			def name
				'csv'
			end
		end

		def pre (out_context)
			if Options.value(out_context.options, OptionHeader.name)
				names(out_context).join(',') + "\n"
			else
				''
			end
		end

		def item (out_context)
			(
				values(out_context).map do | value |
					# https://stackoverflow.com/questions/10451842/how-to-escape-comma-and-double-quote-at-same-time-for-csv-file
					(!value.nil? && (value.to_s.include?(',') || value.to_s.include?('"'))) ? "\"#{value.gsub(/"/,'""')}\"" : value
				end
			).join(',') + "\n"
		end

		def post (out_context)
			''
		end

		def empty (out_context)
			empty_value = Options.value(out_context.options, OptionEmptyValue.name)
			empty_value.nil? ? '' : empty_value
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

		OPTIONS = [
			OptionEmptyValue.new,
			OptionHeader.new
		]
	end
end
