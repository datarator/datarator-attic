# -*- coding: utf-8 -*-
require 'sinatra'
# require 'datarator/reader_yaml'

require "datarator/version"
require "datarator/empty_index"
require "datarator/out_templates"
require "datarator/out_context"
require "datarator/in_params"
require "datarator/types"
require "datarator/empty_index"

require 'ruby-prof'

module Datarator

	class Datarator < Sinatra::Application

		# BATCH_SIZE=1000

		get '/' do
			"TODO site!"
		end

		not_found do
			halt 404, 'page not found'
		end

		post '/dump' do
			request.body.rewind
			in_params = InParams.from_json request.body.read
			in_params.validate
			out_context = OutContext.new in_params

			empty_indexes = Hash.new
			# generate empty indexes
			in_params.columns.each do | column |
				empty_indexes[column.name] = EmptyIndex.indexes(out_context.count, column.empty_percent)
			end

			out_context.values = Array.new

			# batch = BATCH_SIZE < in_params.count ? BATCH_SIZE : in_params.count

			stream do |out|
				out << OutTemplates.pre(out_context)

				empty_value = OutTemplates.empty out_context

				# Profile the code
				# RubyProf.start

				# 0.step(in_params.count, batch) do | row |
				in_params.count.times do | row |
					out_context.values.clear
					# vals = Array.new
					# batch.times do | index |
					# vals.clear
					in_params.columns.each do | column |
						if empty_indexes[column.name].include? row
							out_context.values.push empty_value
							# vals.push empty_value
						else
							out_context.values.push Types.value column.type
							# vals.push Types.value column.type
						end
						# end
						# out_context.values.push vals
						out << OutTemplates.item(out_context)
					end

				end

				# result = RubyProf.stop
				# Print a flat profile to text
				# printer = RubyProf::FlatPrinter.new(result)
				# printer.print(STDOUT)

				out << OutTemplates.post(out_context)
			end

		end
	end
end

require 'datarator/type_name'
