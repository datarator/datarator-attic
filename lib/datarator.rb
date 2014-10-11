# -*- coding: utf-8 -*-
require 'sinatra'

require_relative "datarator/version"
require_relative "datarator/empty_index"
require_relative "datarator/out_templates"
require_relative "datarator/out_context"
require_relative "datarator/in_params"
require_relative "datarator/types"
require_relative "datarator/empty_index"

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
			begin
				in_params = InParams.from_json request.body.read
			rescue ArgumentError => e
				halt 400, e.message
			end

			begin
				in_params.validate
			rescue Exception => e
				halt 409, e.message + e.backtrace.inspect
			end

			out_context = OutContext.new in_params

			# begin
			# 	out_context.validate
			# rescue Exception => e
			# 	halt 409, e.message + e.backtrace.inspect
			# end

			out_context.values = Array.new

			# batch = BATCH_SIZE < in_params.count ? BATCH_SIZE : in_params.count

			stream do |out|
				out << OutTemplates.pre(out_context)

				# Profile the code
				# RubyProf.start

				# 0.step(in_params.count, batch) do | row |
				in_params.count.times do | row |
					# out_context.next_row
					# vals = Array.new
					# batch.times do | index |
					# vals.clear
					in_params.columns.each do | column |
						out_context.values.push Types.value out_context
						out_context.shift_column
					end

					out << OutTemplates.item(out_context)
					out_context.shift_row
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

require_relative 'datarator/type_name'
