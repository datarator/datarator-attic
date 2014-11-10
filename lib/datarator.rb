# -*- coding: utf-8 -*-
require 'sinatra'
require "sinatra/jsonp"

require_relative "datarator/version"
require_relative "datarator/out_templates"
require_relative "datarator/out_context"
require_relative "datarator/types"

require 'ruby-prof'

module Datarator

	class Datarator < Sinatra::Application

		# BATCH_SIZE=1000

		set :public_folder, 'ui'

		get '/' do
			# redirect 'app/index.html'
			'TODO site!'
		end

		get '/api/types' do
			# TODO cache
			content_type :json
			# http://stackoverflow.com/questions/2510792/sinatra-javascript-cross-domain-requests-json
			# jsonp Types.find_all.to_json
			Types.find_all.to_json
		end

		get '/api/templates' do
			# TODO cache
			content_type :json
			# http://stackoverflow.com/questions/2510792/sinatra-javascript-cross-domain-requests-json
			# jsonp OutTemplates.find_all.to_json
			OutTemplates.find_all.to_json
		end

		get '/api/schemas/default' do
			# TODO cache
			content_type :json
			# http://stackoverflow.com/questions/2510792/sinatra-javascript-cross-domain-requests-json
			# jsonp '{"template":"csv","document":"foo_document","count":"10:w","columns":[{"name":"id","type":"row_index"},{"name":"name","type":"name.first_name"}],"options":{"header":"true"}}'

			'{"template":"csv","document":"foo_document","count":"10:w","columns":[{"name":"id","type":"row_index"},{"name":"name","type":"name.first_name"}],"options":{"header":"true"}}'
		end


		not_found do
			halt 404, 'page not found'
		end

		post '/api/schemas' do
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
