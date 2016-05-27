# -*- coding: utf-8 -*-
require 'sinatra'

require_relative "datarator/version"
require_relative "datarator/out_templates"
require_relative "datarator/out_context"
require_relative "datarator/types"

module Datarator

	class Datarator < Sinatra::Application

		# TODO doesn't work for non-production, as bower_components relative reference is invalid
		set :public_folder, ENV['RACK_ENV'] == "production" ? 'ui/dist' : 'ui/app'

		get '/' do
		    send_file File.join(settings.public_folder, 'index.html')
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
			"{\"template\":\"csv\",\"document\":\"foo_document\",\"count\":10,\"columns\":[{\"name\":\"uid\",\"type\":\"#{TypeRowIndex.name}\",\"emptyPercent\": 0},{\"name\":\"first_name\",\"type\":\"#{TypeNameFirstName.name}\",\"emptyPercent\": 0},{\"name\":\"last_name\",\"type\":\"#{TypeNameLastName.name}\",\"emptyPercent\": 0}],\"options\":{\"header\":\"true\"}}"
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
				headers["Content-Disposition"] = "attachment; filename=#{out_context.document}.#{OutTemplates.file_ext(out_context)}"
			else
				# TODO binary types => these can't be plaintext anyway!
				# for no file download
				content_type 'text/plain'
			end

			stream do |out|
				out << OutTemplates.pre(out_context)

				batch_size = 1000

				chunk = ''
				out_context.count.times do | row |

					# giving response in chunks seems to be more performant
					# TODO, go for nested loops to get rid of if on every iteration
					chunk << OutTemplates.item(out_context)
					if row % batch_size == 0
						out << chunk
						chunk = ''
					end

					out_context.shift_row
				end

				out << chunk
				out << OutTemplates.post(out_context)
			end

		end
	end
end

require_relative 'datarator/type_name'
