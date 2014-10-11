require_relative 'in_params'


module Datarator

	class OutContext
		attr_reader :template, :document, :names, :count, :options, :row_index, :column_index, :empty_indexes, :column_options, :empty_value, :out_columns
		attr_writer :options # just to make testing simple
		attr_accessor :values, :escapes

		def initialize(in_params)
			raise ArgumentError, 'in_params type invalid' unless in_params.is_a?(InParams)

			# initialized globally
			self.template = in_params.template
			@document = in_params.document
			@count = in_params.count
			@options = in_params.options
			@row_index = 0
			@column_index = 0
			@values = Array.new

			# initialized per column
			@names = Array.new
			@types = Array.new
			@name_to_index = Hash.new
			@column_options = Array.new
			@empty_indexes = Hash.new
			@escapes = Array.new
			in_params.columns.each_with_index do |column, index|
				@names.push column.name
				@types.push column.type
				@column_options.push column.options
				@name_to_index[column.name] = index

				# generate empty indexes per column type
				@empty_indexes[column.name] = EmptyIndex.indexes(@count, column.empty_percent)

				# set escapes per column type
				@escapes.push Types.escape? column.type
			end

		end

		def shift_row
			@values.clear
			@row_index = row_index + 1
			@column_index = 0
		end

		def shift_column
			@column_index = column_index + 1
		end

		def column_index_for_name(name)
			raise ArgumentError.new 'name can\'t be empty' if name.nil? or name.empty?
			index = @name_to_index[name]
			raise ArgumentError.new 'name can\'t be empty' if index.nil?
			index
		end

		def current_name
			@names[column_index]
		end

		def current_type
			@types[column_index]
		end

		def template=(template)
 			@template = template
			# empty val is affected by template
			@empty_value = OutTemplates.empty @template
		end

		# TODO ?
		# def validate
		# 	@column_options.each do | column_option |
                #
                #
		# 	end
		# end

		def to_liquid
			{
				'template' => @template,
				'document' => @document,
				'names' => @names,
				'values' => @values,
				'escapes' => @escapes,
				'count' => @count,
				'index' => @row_index,
				'options' => @options
			}
		end
	end
end
