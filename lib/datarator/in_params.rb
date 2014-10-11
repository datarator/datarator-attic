require 'json'
require_relative 'types'
require_relative 'in_column'

module Datarator

	class InParams
		attr_accessor :template, :document, :count, :locale, :columns, :options

		class << self
			def from_json (json)
				raise ArgumentError, 'provided string is not a valid json' unless valid_json? json

				data = JSON.parse(json)
				in_params = InParams.new
				in_params.template = data['template']
				in_params.count = data['count'].to_i
				in_params.locale = data['locale']
				in_params.document = data['document']

				in_params.columns = Array.new
				data['columns'].each do |column|
					in_params.columns.push(InColumn.new(column["name"], column["type"], column["emptyPercent"], column["options"]))
				end

				in_params.options = Hash.new
				data['options'].each do |key, value|
					in_params.options[key] = value
				end
				in_params
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

		def validate
			raise "count has to be positive number" unless @count > 1

			@columns.each do | column |
				Types.validate column.type
			end

			OutTemplates.validate @template
		end

	end

end
