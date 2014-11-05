require_relative 'types'
require_relative 'empty_index'
require_relative 'column'

module Datarator
	class Columns

		attr_accessor :columns#, :out_context

		class << self
			def from_json(out_context, data)
				raise ArgumentError, 'expected parsed json data having columns element' if data.nil? or data['columns'].nil?
				columns = Columns.new #out_context
				out_context.columns = columns
				columns.columns = from_json_columns(out_context, data['columns'])
				columns
			end

			def from_json_columns(out_context, nested)
				return nil if nested.nil?

				nested.map do |column|
					Column.new(column["name"], column["type"], column["emptyPercent"], column["options"], from_json_columns(out_context, column['columns']), out_context)
				end
			end
		end

		def initialize()
			@columns = []
			@column_by_name = {}
		end

		def column_by_name(name)
			raise ArgumentError.new 'name can\'t be empty' if name.nil? or name.empty?
			column = @column_by_name[name]
			raise ArgumentError.new "no column found for name: #{name}" if column.nil?
			column
		end

		def column_by_name=(column)
			raise ArgumentError.new "column has to be of type Column" unless column.is_a? Column
			@column_by_name.store(column.name, column)
		end

		def each_deep(&procedure)
			@columns.each do | column |
				column.each_deep(&procedure)
			end
		end

		def each_shallow(&procedure)
			@columns.each do | column |
				column.each_shallow(&procedure)
			end
		end

		def map_shallow(&procedure)
			@columns.map do | column |
				column.map_shallow(&procedure)
			end
		end

		#
		# setters
		#

		def columns=(columns)
			return if columns.nil?

			raise ArgumentError, "columns should be nil or array, but was: #{columns.inspect}" unless columns.kind_of?(Array)
			columns.each do | column |
				raise ArgumentError, "nested columns can't contain nils!" if column.nil?
				raise ArgumentError, "nested columns are expected to be of type Column!" unless column.is_a? Column
			end

			@columns = columns
			@column_by_name.clear
			each_deep() { | column | column.out_context.columns.column_by_name = column }

			# roots relevant only

			# generate empty indexes per column type
			each_shallow() { | column | column.empty_indexes = EmptyIndex.indexes(column.out_context.count, column.empty_percent) }
		end
	end
end
