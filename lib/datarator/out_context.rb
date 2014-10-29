require_relative 'columns'
require_relative 'out_templates'

module Datarator
	class OutContext
		attr_accessor :document, :options, :row_index, :empty_value, :locale #, :column_index

		attr_reader :template, :count, :columns

		class << self
			def from_json (json)
				raise ArgumentError, 'provided string is not a valid json' unless valid_json? json

				data = JSON.parse(json)
				out_context = OutContext.new
				out_context.template = data['template']
				out_context.count = data['count'].to_i
				out_context.locale = data['locale']
				out_context.document = data['document']

				out_context.options = Hash.new
				data['options'].each do |key, value|
					out_context.options[key] = value
				end

				out_context.columns = Columns.from_json(out_context, data)
				out_context
			end

			def valid_json?(json)
				begin
					JSON.parse(json)
					return true
				rescue Exception
					return false
				end
			end
		end

		def initialize()
			@row_index = 0
		end

		def shift_row
			@columns.each_deep() { | column | column.last_value = nil }
			@row_index += 1
		end

		def count=(count)
			raise ArgumentError, "count has to be positive number" unless count.is_a? Integer and count > 0
			@count = count.to_i
		end

		def columns=(columns)
			raise ArgumentError, "columns has to be of type Columns" unless columns.is_a? Columns
			@columns = columns
		end

		def template=(template)
			OutTemplates.validate template
 			@template = template
			# empty val is affected by template
			@empty_value = OutTemplates.empty self
		end

		# TODO ?
		# def validate
		# 	@column_options.each do | column_option |
                #
                #
		# 	end
		# end

		# def to_liquid
		# 	{
		# 		'template' => @template,
		# 		'document' => @document,
		# 		'names' => @names,
		# 		'values' => @values,
		# 		'escapes' => @escapes,
		# 		'count' => @count,
		# 		'index' => @row_index,
		# 		'options' => @options
		# 	}
		# end
	end
end
