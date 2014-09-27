require 'json'
require 'datarator/types'

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
					in_params.columns.push(InColumn.new(column["name"], column["type"], column["empty_percent"]))
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

	class InColumn
		attr_accessor :name, :type, :empty_percent

		def initialize(name, type, empty_percent)
			@name = name
			@type = type

			if empty_percent.nil?
				@empty_percent = 0
			else
				raise ArgumentError, 'empty_percent has to be integer in interval <0,100>' unless empty_percent.to_i.between?(0,100)
				@empty_percent = empty_percent.to_i
			end
		end

		# def hash
		# 	[@name, @type, @empty_percent].hash
		# end

		def ==(other)
			return self.name == other.name && self.type == other.type && self.empty_percent == empty_percent
		end
	end

end
