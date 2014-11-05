# ENV['RACK_ENV'] = 'test'

require 'spec_helper'
require 'rack/test'

module Datarator
	describe Datarator do
		include Rack::Test::Methods

		def app
			# Sinatra::Application
			Datarator
		end

		describe '/' do
			it 'return web page on get' do
				get '/'
				expect(last_response).to be_ok
				expect(last_response.body).to eq('TODO site!')
			end
		end

		describe '/dump' do
			context 'having valid json request' do
				before(:each) do
					json = '{"template":"csv","document":"foo_document","count":"1","locale":"en","columns":[{"name":"foo_name1","type":"const", "options":{"value":"foo1"}},{"name":"foo_name2","type":"const","emptyPercent":"50", "options":{"value":"foo2"}}],"options":{"csv.header":"true"}}'
					post_json('/dump', json)
				end

				it 'returns generated content' do
					expect(last_response).to be_ok
					# expect(last_response.body).to match(/^([- a-zA-Z]+,[- a-zA-Z]*\n)+$/m)
					expect(last_response.body).to match(/^(foo1,(foo2|)\n)+$/m)
				end
			end

			context 'having syntactically invalid json request' do
				before(:each) do
					json = '{"template'
					post_json('/dump', json)
				end

				it 'returns HTTP error 400' do
					expect(last_response.status).to eq 400
					# TODO check error itself
				end
			end

			context 'having invalid json request data' do
				before(:each) do
					json = '{"template":"csv","document":"foo_document","count":"10","locale":"en","columns":[{"name":"foo_name1","type":"non_existing"},{"name":"foo_name2","type":"name.first_name","emptyPercent":"50"}],"options":{"csv.header":"true","prettyprint":"true"}}'
					post_json('/dump', json)
				end

				it 'returns HTTP error 400' do
					expect(last_response.status).to eq 400
					# TODO check error itself
				end
			end

		end

		describe '/non_existing' do
			it 'return 404 page' do
				get '/non_existing'
				expect(last_response.status).to eq 404
				expect(last_response.body).to eq('page not found')
			end
		end

		describe '/types' do
			it 'return json with all templates on get' do
				get '/types'
				expect(last_response).to be_ok
				expect(last_response.body).to eq("[{\"name\":\"const\",\"nested\":false,\"options\":[{\"name\":\"value\",\"mandatory\":true,\"boolean\":false}]},{\"name\":\"row_index\",\"nested\":false,\"options\":[]},{\"name\":\"copy\",\"nested\":false,\"options\":[{\"name\":\"from\",\"mandatory\":true,\"boolean\":false}]},{\"name\":\"list.seq\",\"nested\":true,\"options\":[]},{\"name\":\"list.rand\",\"nested\":true,\"options\":[]},{\"name\":\"join\",\"nested\":true,\"options\":[{\"name\":\"separator\",\"mandatory\":false,\"boolean\":false}]},{\"name\":\"name.name\",\"nested\":false,\"options\":[]},{\"name\":\"name.first_name\",\"nested\":false,\"options\":[]}]")
			end		end

		describe '/templates' do
			it 'return json with all templates on get' do
				get '/templates'
				expect(last_response).to be_ok
				expect(last_response.body).to eq('[{"name":"csv","options":[{"name":"header","mandatory":false,"boolean":true}]},{"name":"sql","options":[]}]')
			end
		end


		def post_json(uri, json)
		  post(uri, json, { "CONTENT_TYPE" => "application/json" })
		end
	end
end
