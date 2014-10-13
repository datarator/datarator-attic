require 'spec_helper'
require 'datarator/type_row_index'

module Datarator
	describe TypeRowIndex do

		describe '.value' do
			before(:each) do
				in_params = InParams.new
				in_params.document = 'table1'
				in_params.columns = [ Column.new("name1", TypeRowIndex.name, "0", nil )]
				in_params.count = 1
				in_params.template = 'csv'
				@out_context = OutContext.new in_params
			end

			it 'returns row index starting with 0' do
				expect(TypeRowIndex.new.value @out_context ).to eq 0
				@out_context.shift_row
				expect(TypeRowIndex.new.value @out_context ).to eq 1
			end
		end

		describe '.name' do
			it 'returns a constant: \'row_index\'' do
				expect(TypeRowIndex.name).to eq 'row_index'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeRowIndex.new.escape?).to eq false
			end
		end
	end
end
