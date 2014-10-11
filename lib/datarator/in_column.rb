require 'json'
require_relative 'types'

module Datarator

	class InColumn
		attr_accessor :name, :type, :empty_percent, :options

		def initialize(name, type, empty_percent, options)
			@name = name
			@type = type
			@options = options

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
			#TODO options
			return self.name == other.name && self.type == other.type && self.empty_percent == empty_percent
		end
	end
end
