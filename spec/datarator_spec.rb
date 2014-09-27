ENV['RACK_ENV'] = 'test'

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

		describe '/' do
			context 'having valid json' do
				before(:each) do
					json = '{"template":"csv","document":"foo_document","count":"10","locale":"en","columns":[{"name":"foo_name1","type":"name.first_name"},{"name":"foo_name2","type":"name.first_name","empty_percent":"50"}],"options":{"csv.header":"true","prettyprint":"true"}}'
					post_json('/dump', json)
				end

				it 'TODO shows web page' do
					expect(last_response).to be_ok
					expect(last_response.body).to match(/^([- a-zA-Z]+,[- a-zA-Z]*\n)+$/m)
				end
			end
		end

		def post_json(uri, json)
		  post(uri, json, { "CONTENT_TYPE" => "application/json" })
		end
	end
end
