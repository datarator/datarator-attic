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

		set :public_folder, 'ui'

		get '/' do
			# redirect 'app/index.html'
			'TODO site!'
		end

		get '/api/types' do
			# TODO cache
			content_type :json
			Types.find_all.to_json
		end

		get '/api/templates' do
			# TODO cache
			content_type :json
			OutTemplates.find_all.to_json
		end

		get '/api/schemas/default' do
			# TODO cache
			content_type :json
			'{"template":"csv","document":"foo_document","count":"10:w","columns":[{"name":"","type":""},{"name":"","type":""}],"options":{"header":"true"}}'
		end


		not_found do
			halt 404, 'page not found'
		end

		post '/api/schemas' do
			# TODO test params in specs :json + :outTarget
			# read param first, fallback to body req
			json = params[:json]
			if json.nil?
				request.body.rewind
				json = request.body.read
			end

			begin
				out_context = OutContext.from_json json
			rescue ArgumentError => e
				halt 400, e.message + e.backtrace.inspect
			end

			# begin
			# 	out_context.validate
			# rescue Exception => e
			# 	halt 409, e.message + e.backtrace.inspect
			# end

			# batch = BATCH_SIZE < in_params.count ? BATCH_SIZE : in_params.count

			# TODO for binary? => future? 
			# content_type 'application/download'

			# for in page generation, we need no type stuff
			if params[:outTarget].nil? || params[:outTarget] == 'file'
				content_type OutTemplates.content_type(out_context)
				headers["Content-Disposition"] = "attachment; filename=datarator.#{OutTemplates.file_ext(out_context)}"
			else
				# TODO binary types => these can't be plaintext anyway!
				# for no file download
				content_type 'text/plain'
			end

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
