require 'spec_helper'
require 'datarator/in_params'

module Datarator
	describe InParams do

		describe '.from_json' do
			context 'having valid json' do
				before(:each) do
					json = '{"template":"foo_template","document":"foo_document","count":"10","locale":"en","columns":[{"name":"foo_name1","type":"foo_type1"},{"name":"foo_name2","type":"foo_type2","empty_percent":"50"}],"options":{"csv.header":"true","prettyprint":"true"}}'
					@inParams = InParams.from_json json
				end

				it 'inits template property' do
					expect(@inParams.template).to eq "foo_template"
				end

				it 'inits document property' do
					expect(@inParams.document).to eq "foo_document"
				end

				it 'inits count property' do
					expect(@inParams.count).to eq 10
				end

				it 'inits locale property' do
					expect(@inParams.locale).to eq "en"
				end


				it 'inits columns property' do
					expect(@inParams.columns).to eq([ InColumn.new("foo_name1", "foo_type1", "0"), InColumn.new("foo_name2", "foo_type2", "50") ])
				end

				it 'inits options property' do
					expect(@inParams.options).to eq({ 'csv.header' => 'true', 'prettyprint' => 'true' })
				end
			end

			it 'raises ArgumentError for invalid json format' do
				expect{ InParams.from_json '{template":"foo"' }.to raise_error(ArgumentError)
			end

		end

		describe '.validate' do
			it 'raises error for unknown column type' do
				json = '{"template":"foo_template","document":"foo_document","count":"10","locale":"en","columns":[{"name":"foo_name1","type":"foo_type1"}],"options":{"csv.header":"true","prettyprint":"true"}}'
				in_params = InParams.from_json json
				expect{ in_params.validate }.to raise_error(/type not supported/)
			end

			it 'raises error for non-positive count' do
				json = '{"template":"foo_template","document":"foo_document","count":"-1","locale":"en","columns":[{"name":"foo_name1","type":"name"}],"options":{"csv.header":"true","prettyprint":"true"}}'
				in_params = InParams.from_json json
				expect{ in_params.validate }.to raise_error(/count has to be positive/)
			end

		end
	end
end
