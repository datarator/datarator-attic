require 'spec_helper'
require 'datarator/columns'

module Datarator
	describe Columns do
		before(:each) do
			@out_context = OutContext.new
			@out_context.count=2
			@out_context.template = 'csv'

			@columns = Columns.new
			@out_context.columns = @columns

			@column1 = Column.new("name1", TypeNameFirstName.name, "0", nil, nil, @out_context)
			@column2 = Column.new("name2", TypeNameFirstName.name, "0", nil, nil, @out_context)
			@columns.columns = [ @column1, @column2 ]
		end

		describe '.column_by_name=' do
			it 'sets column for name' do
				column = Column.new("name3", TypeNameFirstName.name, "0", nil, nil, @out_context)
				@columns.column_by_name = column
				expect(@columns.column_by_name 'name3').to eq column
			end

			it 'raises ArgumentError for empty column' do
				expect{ @columns.column_by_name = nil }.to raise_error(ArgumentError)
			end
		end

		describe '.column_by_name' do
			it 'returns column for available column name' do
				expect(@columns.column_by_name 'name1').to eq @column1
				expect(@columns.column_by_name 'name2').to eq @column2
			end

			it 'raises ArgumentError for empty column name' do
				expect{ @columns.column_by_name nil }.to raise_error(ArgumentError)
				expect{ @columns.column_by_name '' }.to raise_error(ArgumentError)
			end

			it 'raises ArgumentError for not found column name' do
				expect{ @columns.column_by_name 'not_found' }.to raise_error(ArgumentError)
			end
		end

		describe '.columns=' do
			it 'adds columns' do
				column = Column.new('foo', TypeNameFirstName.name, '0', nil, nil, @out_context)
				@columns.columns = [ column ]
				expect(@columns.columns).to eq [ column ]
			end

			it 'updates column_by_name' do
				column = Column.new('foo', TypeNameFirstName.name, '0', nil, nil, @out_context)
				@columns.columns = [ column ]
				expect(@columns.column_by_name 'foo').to eq column
			end

			it 'raises ArgumentError for non array' do
				expect{ @columns.columns = 'non_array' }.to raise_error(ArgumentError)
			end

			it 'raises ArgumentError for nil column element' do
				expect{ @columns.columns = [ nil ] }.to raise_error(ArgumentError)
			end

			it 'raises ArgumentError for non Column type element' do
				expect{ @columns.columns = [ 'non_column' ] }.to raise_error(ArgumentError)
			end


			it 'sets empty_indexes per column' do
				column = Column.new('foo', TypeNameFirstName.name, '50', nil, nil, @out_context)
				@columns.columns = [ column ]
				expect(column.empty_indexes.size ).to eq @out_context.count / 2
			end
		end
	end
end

