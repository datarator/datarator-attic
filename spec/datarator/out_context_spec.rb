require 'spec_helper'
require 'datarator/out_context'

module Datarator
	describe OutContext do
		before(:each) do
			@out_context = OutContext.new
			@out_context.document = 'table1'
			@out_context.count=1
			@out_context.template = 'csv'

			columns = Columns.new
			@out_context.columns = columns

			@column1 = Column.new("name1", TypeNameName.name, "0", nil, nil, @out_context)
			# columns.add_column @column1
			@column2 = Column.new("name2", TypeNameName.name, "50", nil, nil, @out_context)
			# columns.add_column @column2
			columns.columns = [ @column1, @column2 ]
		end

		describe '.from_json' do
			context 'having valid json' do
				before(:each) do
					json = '{"template":"csv","document":"table1","count":"1","locale":"en","columns":[{"name":"name1","type":"name.name"},{"name":"name2","type":"name.name","emptyPercent":"50"}],"options":{"header":"true","irrelevant_option":"true"}}'
					@out_context = OutContext.from_json json
				end

				it 'sets template property' do
					expect(@out_context.template).to eq "csv"
				end

				it 'sets count property' do
					expect(@out_context.count).to eq 1
				end

				# it 'sets locale property' do
				# 	expect(@out_context.locale).to eq "en"
				# end

				it 'sets document property' do
					expect(@out_context.document).to eq "table1"
				end


				it 'sets columns property' do
					expect(@out_context.columns.columns[0]).to eq @column1
					expect(@out_context.columns.columns[1]).to eq @column2
				end

				it 'sets relevant options' do
					expect(@out_context.options).to eq({ 'header' => true, 'empty_value' => '' })
				end
			end

			it 'raises ArgumentError for invalid json format' do
				expect{ OutContext.from_json '{template":"foo"' }.to raise_error(ArgumentError)
			end
		end

		describe '.count=' do
			it 'sets count property' do
				@out_context.count = 100
				expect(@out_context.count).to eq 100
			end

			it 'raises error for non-positive count' do
				expect{ OutContext.new.count=-1 }.to raise_error(ArgumentError)
				expect{ OutContext.new.count=0 }.to raise_error(ArgumentError)
			end

			it 'raises error for non-integer' do
				expect{ OutContext.new.count="1" }.to raise_error(ArgumentError)
				expect{ OutContext.new.count=1.1 }.to raise_error(ArgumentError)
			end

		end

		describe '.columns=' do
			it 'sets columns' do
				columns = Columns.new
				@out_context.columns = columns
				expect(@out_context.columns).to eq columns
			end

			it 'raises error for not Columns type' do
				expect{ OutContext.new.columns="foo" }.to raise_error(ArgumentError)
			end
		end

		describe '.template=' do
			it 'sets template property' do
				@out_context.template = 'sql'
				expect(@out_context.template).to eq 'sql'
			end

			it 'sets empty_value for template' do
				@out_context.template = 'sql'
				expect(@out_context.empty_value).to eq 'NULL'
			end


			it 'raises error for unknown column template' do
				expect{ OutContext.new.template="non_exising" }.to raise_error(ArgumentError)
			end

			it 'raises error for empty column template' do
				expect{ OutContext.new.template="" }.to raise_error(ArgumentError)
				expect{ OutContext.new.template=nil }.to raise_error(ArgumentError)
			end
		end

		describe '.shift_row' do
			it 'increments current row index' do
				@out_context.shift_row
				expect(@out_context.row_index).to eq 1
			end

			it 'clears last_value for all columns' do
				@out_context.columns.columns[0].value
				@out_context.columns.columns[1].value
				expect(@out_context.columns.columns[0].last_value).not_to eq nil
				expect(@out_context.columns.columns[1].last_value).not_to eq nil
				@out_context.shift_row
				expect(@out_context.columns.columns[0].last_value).to eq nil
				expect(@out_context.columns.columns[1].last_value).to eq nil
			end
		end
	end
end
