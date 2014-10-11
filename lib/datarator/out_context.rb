require_relative 'in_params'
require_relative 'empty_index'


module Datarator

	class OutContext
		attr_reader :template, :document, :count, :options, :row_index, :column_index, :empty_value, :columns
		attr_writer :options # just to make testing simple

		def initialize(in_params)
			raise ArgumentError, 'in_params type invalid' unless in_params.is_a?(InParams)

			self.template = in_params.template
			@document = in_params.document
			@count = in_params.count
			@options = in_params.options
			@row_index = 0
			@column_index = 0
			@name_to_index = Hash.new
			@columns = in_params.columns
			@columns.each_with_index do |column, index|
				@name_to_index[column.name] = index

				# generate empty indexes per column type
				column.empty_indexes = EmptyIndex.indexes(@count, column.empty_percent)

				# set escapes per column type
				column.escape = Types.escape? column.type
			end
		end

		def shift_row
			# TODO consider tree structure
			columns.each do | column |
				column.value = nil
			end
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

		#
		# current prefix ommited
		#
		def name
			@columns[column_index].name
		end

		def type
			@columns[column_index].type
		end

		def escape
			@columns[column_index].escape
		end

		def empty_value?
			@columns[column_index].empty_indexes.include? row_index
		end

		def value
			@columns[column_index].value
		end

		def value=(value)
			@columns[column_index].value = value
		end

		#
		# aggregating
		#
		def names
			@columns.map do | column |
				column.name
			end
		end

		def values
			@columns.map do | column |
				column.value
			end
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
