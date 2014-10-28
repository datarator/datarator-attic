require 'spec_helper'
require 'datarator/type_join'

module Datarator
	describe TypeJoin do

		describe '.value' do
			before(:each) do
				@out_context = OutContext.new
				@out_context.count=4
				columns = Columns.new
				@out_context.columns = columns

				nested1 = Column.new("nest1", TypeConst.name, "0", { "value" => "value1"}, nil, @out_context)
				nested2 = Column.new("nest2", TypeConst.name, "0", { "value" => "value2"}, nil, @out_context)
				@nested = [ nested1, nested2 ]
			end

			context 'for non-empty separator' do
				before(:each) do
					@column1 = Column.new("name1", TypeJoin.name, "0", { "separator" => ", "},  @nested, @out_context)
					@out_context.columns.columns = [ @column1 ]
				end

				it 'returns separator-joined nested column values' do
					expect(TypeJoin.new.value @column1 ).to eq 'value1, value2'
				end
			end

			context 'for no separator provided' do
				before(:each) do
					@column1 = Column.new("name1", TypeJoin.name, "0", {},  @nested, @out_context)
					@out_context.columns.columns = [ @column1 ]
				end

				it 'returns joined nested column values' do
					expect(TypeJoin.new.value @column1 ).to eq 'value1value2'
				end
			end

			context 'for no options provided' do
				before(:each) do
					@column1 = Column.new("name1", TypeJoin.name, "0", nil,  @nested, @out_context)
					@out_context.columns.columns = [ @column1 ]
				end

				it 'returns joined nested column values' do
					expect(TypeJoin.new.value @column1 ).to eq 'value1value2'
				end
			end
		end

		describe '.name' do
			it 'returns a constant: \'join\'' do
				expect(TypeJoin.name).to eq 'join'
			end
		end

		describe '.escape?' do
			it 'returns false' do
				expect(TypeJoin.new.escape? @column1).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeJoin.new.nested? @column1).to be true
			end
		end

		describe '.separator' do
			it 'returns empty string for no option separator' do
				expect(TypeJoin.name).to eq 'join'
			end

			it 'returns empty string for no option separator' do
				expect(TypeJoin.name).to eq 'join'
			end

		end

	end
end
