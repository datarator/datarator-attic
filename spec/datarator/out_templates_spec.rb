require 'spec_helper'
require 'datarator/out_templates'
require 'datarator/out_context'
require 'datarator/type_name'

module Datarator
	describe OutTemplates do
		before(:each) do
			in_params = InParams.new
			in_params.document = 'table1'
			in_params.columns = [ Column.new("name1", TypeNameName.name, "0", nil), Column.new("name2", TypeNameName.name, "0", nil), Column.new("name3", TypeNameName.name, "0", nil)]
			in_params.count = 1
			in_params.template = 'csv'
			@out_context = OutContext.new in_params
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

			context 'with sql template' do
				before(:each) do
					@out_context.template = 'sql'
				end

				it 'returns empty string' do
					expect(OutTemplates.pre(@out_context)).to eq ''
				end
			end

		end

		describe '.item' do
			context 'with csv template' do
				before(:each) do
					@out_context.template = 'csv'
				end

				it 'returns comma separated values' do
					@out_context.values = [ 'value1', 'value2', 'value3' ]
					expect(OutTemplates.item(@out_context)).to eq "value1,value2,value3\n"
				end

				it 'returns comma separated values with escaped commas' do
					@out_context.values = [ '1,1', 'value2', 'value3' ]
					expect(OutTemplates.item(@out_context)).to eq "'1,1',value2,value3\n"
				end
			end

			context 'with sql template' do
				before(:each) do
					@out_context.template = 'sql'
				end

				it 'returns sql inserts with strings escaped' do
					@out_context.values = [ 'value1', 'value2', 1 ]
					@out_context.escapes = [ true, true, false ]
					expect(OutTemplates.item(@out_context)).to eq "INSERT INTO table1 (name1,name2,name3) values ('value1','value2',1);\n"
				end

				it 'returns sql inserts with escaped character: \'' do
					@out_context.values = [ 'value1', "foo'bar", 1 ]
					@out_context.escapes = [ true, true, false ]
					expect(OutTemplates.item(@out_context)).to eq "INSERT INTO table1 (name1,name2,name3) values ('value1','foo\'\'bar',1);\n"
				end
			end

		end

		describe '.post' do
			context 'with csv template' do
				before(:each) do
					@out_context.template = 'csv'
				end
				it 'returns empty string' do
					expect(OutTemplates.post(@out_context)).to eq ''
				end
			end

			context 'with sql template' do
				before(:each) do
					@out_context.template = 'sql'
				end
				it 'returns empty string' do
					expect(OutTemplates.post(@out_context)).to eq ''
				end
			end

		end

		describe '.empty' do
			context 'with csv template' do
				before(:each) do
					@out_context.template = 'csv'
				end
				it 'returns empty string' do
					expect(OutTemplates.empty(@out_context.template)).to eq ''
				end
			end

			context 'with sql template' do
				before(:each) do
					@out_context.template = 'sql'
				end
				it 'returns string: NULL' do
					expect(OutTemplates.empty(@out_context.template)).to eq 'NULL'
				end
			end
		end

		describe '.validate' do
			context 'for csv output template' do
				it 'passes validation' do
					expect(OutTemplates.validate 'csv').to eq nil
				end
			end

			context 'for sql output template' do
				it 'passes validation' do
					expect(OutTemplates.validate 'sql').to eq nil
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
