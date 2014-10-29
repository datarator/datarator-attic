require 'json'
require_relative 'types'

module Datarator

	class Column
		# provided in input
		attr_reader :name, :type, :options, :nested, :empty_percent, :parent, :value
		# output related
		attr_accessor :last_value, :empty_indexes, :out_context

		def initialize(name, type, empty_percent, options, nested, out_context)
			self.out_context = out_context
			self.name = name
			self.type = type
			self.empty_percent = empty_percent
			@options = options
			self.nested = nested
		end

		def escape
			# TODO cache
			Types.escape? self
		end

		#
		# setters
		#
		def name=(name)
			raise ArgumentError.new 'name can\'t be empty' if name.nil? or name.empty?
			@name = name
		end

		def type=(type)
			Types.validate type
			@type = type
		end

		def empty_percent=(empty_percent)
			if empty_percent.nil?
				@empty_percent = 0
			else
				raise ArgumentError, "empty_percent has to be integer in interval <0,100>, but was: #{empty_percent}" unless empty_percent.to_i.between?(0,100)
				@empty_percent = empty_percent.to_i
			end
		end

		def out_context=(out_context)
			raise ArgumentError, 'out_context is expected to be of type OutContext!' unless out_context.is_a? OutContext
			@out_context = out_context
		end

		def nested=(nested)
			# raise ArgumentError, "nested columns expected, but not found for: #{name}" if Types.nested?(self) and nested.nil?
			# raise ArgumentError, "nested columns not expected, but found for: #{name}" if !Types.nested?(self) and !nested.nil?

			unless nested.nil?
				raise ArgumentError, "nested columns should be nil or array, but was: #{nested.inspect}" unless nested.kind_of?(Array)
				nested.each do | column |
					raise ArgumentError, "nested columns can't contain nils!" if column.nil?
					raise ArgumentError, "nested columns are expected to be of type Column!" unless column.is_a? Column
				end
			end

			@nested = nested
		end

		# def hash
		# 	[@name, @type, @empty_percent].hash
		# end

		def ==(other)
			#TODO options
			return self.name == other.name && self.type == other.type && self.empty_percent == empty_percent && self.options == other.options && self.parent == other.parent && self.nested == other.nested
		end

		def value()
			# don't worry about empty vals, as these are handled in: types.value()
			@last_value = Types.value(self)
		end

		def empty_index?()
			# nested columns don't have empty_indexes initialized
			return false if @empty_indexes.nil?

			@empty_indexes.include? @out_context.row_index
		end

		def each_deep(&procedure)
			procedure.call(self)
			unless @nested.nil?
				@nested.each do | column |
					column.each_deep(&procedure)
				end
			end
		end

		def each_shallow(&procedure)
			procedure.call(self)
		end

		def map_shallow(&procedure)
			procedure.call(self)
		end
	end
end
