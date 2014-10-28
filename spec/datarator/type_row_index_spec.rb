require 'spec_helper'
require 'datarator/type_row_index'

module Datarator
	describe TypeRowIndex do

		describe '.value' do
			before(:each) do
				@out_context = OutContext.new
				@out_context.count=4

				columns = Columns.new
				@out_context.columns = columns

				@column1 = Column.new("name1", TypeRowIndex.name, "0", nil, nil, @out_context)
				columns.columns = [ @column1 ]
			end

			it 'returns row index starting with 0' do
				3.times do | idx |
					expect(TypeRowIndex.new.value @column1 ).to eq idx
					@out_context.shift_row
				end
			end
		end

		describe '.name' do
			it 'returns a constant: \'row_index\'' do
				expect(TypeRowIndex.name).to eq 'row_index'
			end
		end

		describe '.escape?' do
			it 'returns false' do
				expect(TypeRowIndex.new.escape? @column1).to be false
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeRowIndex.new.nested? @column1).to be false
			end
		end

	end
end
