require_relative 'columns'
require_relative 'options'
require_relative 'out_templates'

module Datarator
	class OutContext
		attr_accessor :document, :row_index, :empty_value, :locale #, :column_index

		attr_reader :template, :count, :columns, :options

		class << self
			def from_json (json)
				raise ArgumentError, 'provided string is not a valid json' unless valid_json? json

				data = JSON.parse(json)
				out_context = OutContext.new
				out_context.template = data['template']
				out_context.count = data['count'].to_i
				out_context.locale = data['locale']
				out_context.document = data['document']
				out_context.options = data['options']
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

		def options=(options)
			@options = {}

			OutTemplates.options(@template).each do | option |
				# raise ArgumentError, "array of options expected (for template: #{@template})!" unless options.kind_of?(Array)
				raise ArgumentError, "array of options can't contain nils (for template: #{@template})!" if option.nil?
				raise ArgumentError, "array of options expected to be of type Option (for template: #{@template})!" unless option.is_a? Option
				raise ArgumentError, "mandatory option expected, but not found: #{option.class.name} (for template: #{@template})" if option.mandatory? && (options.nil? || options[option.class.name].nil?)

				@options[option.class.name] = Options.value(options, option.class.name)
			end
		end

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
