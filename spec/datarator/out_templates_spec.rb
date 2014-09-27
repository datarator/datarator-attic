require 'spec_helper'
require 'datarator/out_templates'
require 'datarator/out_context'

module Datarator
	describe OutTemplates do
		before(:each) do
			in_params = InParams.new
			in_params.columns = [ InColumn.new("name1", "foo", "0"), InColumn.new("name2", "foo", "0"), InColumn.new("name3", "foo", "0")]
			@out_context = OutContext.new in_params
			@out_context.values = [ 'value1', 'value2', 'value3' ]
		end

		describe '.pre' do
			context 'with csv template' do
				before(:each) do
					@out_context.template = 'csv'
				end

				context 'with header explicitly disabled'
				it 'returns empty string' do
					@out_context.options = { 'header' => 'false' }
					expect(OutTemplates.pre(@out_context)).to eq ''
				end

				context 'with csv template and header implicitly disabled'
				it 'returns empty string' do
					expect(OutTemplates.pre(@out_context)).to eq ''
				end

				context 'with csv template and header enabled'
				it 'returns comma separated names' do
					@out_context.options = { 'header' => 'true' }
					expect(OutTemplates.pre(@out_context)).to eq "name1,name2,name3\n"
				end
			end

		end

		describe '.item' do
			context 'with csv template' do
				before(:each) do
					@out_context.template = 'csv'
				end

				it 'returns comma separated values' do
					expect(OutTemplates.item(@out_context)).to eq "value1,value2,value3\n"
				end

			end
		end

		describe '.post' do
			context 'with csv template'
			before(:each) do
				@out_context.template = 'csv'
			end
			it 'returns empty string' do
				expect(OutTemplates.post(@out_context)).to eq ''
			end
		end

		describe '.empty' do
			context 'with csv template'
			before(:each) do
				@out_context.template = 'csv'
			end
			it 'returns empty string' do
				expect(OutTemplates.empty(@out_context)).to eq ''
			end
		end

		describe '.validate' do
			context 'for existing output template' do
				it 'passes validation' do
					expect(OutTemplates.validate 'csv').to eq nil
				end
			end

			context 'for non-existing output template' do
				it 'raises ArgumentError' do
					expect{ OutTemplates.validate 'non_existing' }.to raise_error(/template not supported/)
				end
			end

		end


	end
end
