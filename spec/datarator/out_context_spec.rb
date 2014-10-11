require 'spec_helper'
require 'datarator/out_context'

module Datarator
	describe OutContext do
		before(:each) do
			in_params = InParams.new
			in_params.document = 'table1'
			in_params.columns = [ InColumn.new("name1", TypeNameFirstName.name, "0", nil), InColumn.new("name2", TypeNameName.name, "0", nil)]
			in_params.count = 1
			in_params.template = 'csv'
			@out_context = OutContext.new in_params
		end

		describe '.shift_column' do
			it 'increments current column index' do
				@out_context.shift_column
				expect(@out_context.column_index).to eq 1
			end
		end

		describe '.shift_row' do
			it 'increments current row index' do
				@out_context.shift_row
				expect(@out_context.row_index).to eq 1
			end

			it 'resets current column index' do
				@out_context.shift_column
				@out_context.shift_row
				expect(@out_context.column_index).to eq 0
			end

			it 'clears values' do
				@out_context.values = ['foo1', 'foo2']
				@out_context.shift_row
				expect(@out_context.values.size).to eq 0
			end
		end

		describe '.current_name' do
			it 'returns column name on current column index' do
				expect(@out_context.current_name).to eq 'name1'
				@out_context.shift_column
				expect(@out_context.current_name).to eq 'name2'
			end
		end

		describe '.current_type' do
			it 'returns column type on current column index' do
				expect(@out_context.current_type).to eq TypeNameFirstName.name
				@out_context.shift_column
				expect(@out_context.current_type).to eq TypeNameName.name
			end
		end

		describe '.column_index_for_name' do
			it 'returns column index for available column name' do
				expect(@out_context.column_index_for_name 'name1').to eq 0
				expect(@out_context.column_index_for_name 'name2').to eq 1
			end

			it 'raises ArgumentError for empty column name' do
				expect{ @out_context.column_index_for_name nil }.to raise_error(ArgumentError)
				expect{ @out_context.column_index_for_name '' }.to raise_error(ArgumentError)
			end

			it 'raises ArgumentError for not found column name' do
				expect{ @out_context.column_index_for_name 'not_found' }.to raise_error(ArgumentError)
			end
		end
	end
end
