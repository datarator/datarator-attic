require 'spec_helper'
require 'datarator/out_template_csv'
require 'datarator/type_name'

module Datarator
	describe OutTemplates do
		before(:each) do
			@out_context = OutContext.new
			@out_context.document = 'table1'
			@out_context.count = 1
			@out_context.template = 'csv'

			columns = Columns.new
			@out_context.columns = columns
			column1 = Column.new("name1", TypeConst.name, "0", { "value" => "value1"} , nil, @out_context)
			column2 = Column.new("name2", TypeConst.name, "0", { "value" => "value2"}, nil, @out_context)
			columns.columns = [ column1, column2 ]
		end

		describe '.pre' do
			context 'having header explicitly disabled' do
				it 'returns empty string' do
					@out_context.options = { 'header' => 'false' }
					expect(OutTemplateCsv.new.pre @out_context).to eq ''
				end
			end

			context 'having header implicitly disabled' do
				it 'returns empty string' do
					expect(OutTemplateCsv.new.pre @out_context).to eq ''
				end
			end

			context 'having header enabled' do
				it 'returns comma separated names' do
					@out_context.options = { 'header' => 'true' }
					expect(OutTemplateCsv.new.pre @out_context).to eq "name1,name2\n"
				end
			end
		end

		describe '.item' do
			it 'returns comma separated values' do
				expect(OutTemplateCsv.new.item @out_context).to eq "value1,value2\n"
			end

			it 'returns comma separated values with escaped commas in values' do
				columns = Columns.new
				@out_context.columns = columns

				column1 = Column.new("name2", TypeConst.name, "0", { "value" => "1,1"}, nil, @out_context)
				column2 = Column.new("name2", TypeConst.name, "0", { "value" => "value2"}, nil, @out_context)
				columns.columns = [ column1, column2 ]

				expect(OutTemplateCsv.new.item @out_context).to eq "\"1,1\",value2\n"
			end

			it 'returns comma separated values with escaped doubleqoutes in values' do
				columns = Columns.new
				@out_context.columns = columns

				column1 = Column.new("name2", TypeConst.name, "0", { "value" => 'foo"bar'}, nil, @out_context)
				column2 = Column.new("name2", TypeConst.name, "0", { "value" => "value2"}, nil, @out_context)
				columns.columns = [ column1, column2 ]

				expect(OutTemplateCsv.new.item @out_context).to eq "\"foo\"\"bar\",value2\n"
			end
		end

		describe '.post' do
			it 'returns empty string' do
				expect(OutTemplateCsv.new.post @out_context).to eq ''
			end
		end

		describe '.empty' do
			it 'returns empty string' do
				expect(OutTemplateCsv.new.empty @out_context).to eq ''
			end
		end

		describe '.options' do
			it 'returns header option' do
				expect( OutTemplateCsv.new.options ).to match_array([ OptionHeader.new ])
			end
		end

		describe '.content_type' do
			it 'returns csv mime type' do
				expect(OutTemplateCsv.new.content_type ).to eq 'csv/plain'
			end
		end

		describe '.file_ext' do
			it 'returns csv' do
				expect( OutTemplateCsv.new.file_ext ).to eq 'csv'
			end
		end
	end
end
