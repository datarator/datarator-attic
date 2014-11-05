# -*- coding: utf-8 -*-
require 'sinatra'

require_relative "datarator/version"
require_relative "datarator/out_templates"
require_relative "datarator/out_context"
require_relative "datarator/types"

require 'ruby-prof'

module Datarator

	class Datarator < Sinatra::Application

		# BATCH_SIZE=1000

		get '/' do
			"TODO site!"
		end

		get '/types' do
			# TODO cache
			Types.find_all.to_json
		end

		get '/templates' do
			# TODO cache
			OutTemplates.find_all.to_json
		end

		not_found do
			halt 404, 'page not found'
		end

		post '/dump' do
			request.body.rewind
			begin
				out_context = OutContext.from_json request.body.read
			rescue ArgumentError => e
				halt 400, e.message + e.backtrace.inspect
			end

			# begin
			# 	out_context.validate
			# rescue Exception => e
			# 	halt 409, e.message + e.backtrace.inspect
			# end

			# batch = BATCH_SIZE < in_params.count ? BATCH_SIZE : in_params.count

			stream do |out|
				out << OutTemplates.pre(out_context)

				# Profile the code
				# RubyProf.start

				# 0.step(in_params.count, batch) do | row |
				out_context.count.times do #| row |
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
