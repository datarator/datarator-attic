require_relative 'in_params'

module Datarator

	class OutContext
		attr_reader :template, :document, :names, :count, :options
		attr_writer :template, :options # just to make testing simple
		attr_accessor :values, :escapes, :index

		def initialize(in_params)
			raise ArgumentError, 'in_params type invalid' unless in_params.is_a?(InParams)

			@template = in_params.template
			@document = in_params.document
			@count = in_params.count
			@options = in_params.options

			@names = Array.new
			in_params.columns.each do |column|
				@names.push column.name
			end
		end


		def to_liquid
			{
				'template' => @template,
				'document' => @document,
				'names' => @names,
				'values' => @values,
				'escapes' => @escapes,
				'count' => @count,
				'index' => @index,
				'options' => @options
			}
		end
	end
end
