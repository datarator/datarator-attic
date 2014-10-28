require 'spec_helper'
require 'datarator/type_list'

module Datarator
	describe TypeListSeq do

		describe '.value' do
			before(:each) do
				@out_context = OutContext.new
				@out_context.count=4
				columns = Columns.new
				@out_context.columns = columns

				nested1 = Column.new("nest1", TypeConst.name, "0", { "value" => "value1"}, nil, @out_context)
				nested2 = Column.new("nest2", TypeConst.name, "0", { "value" => "value2"}, nil, @out_context)
				@column1 = Column.new("name1", TypeListSeq.name, "0", nil, [ nested1, nested2 ] , @out_context)
				columns.columns = [ @column1 ]
			end

			it 'returns nested column values sequentially' do
				expect(TypeListSeq.new.value @column1 ).to eq 'value1'
				@out_context.shift_row
				expect(TypeListSeq.new.value @column1 ).to eq 'value2'
				@out_context.shift_row
				expect(TypeListSeq.new.value @column1 ).to eq 'value1'
			end
		end

		describe '.name' do
			it 'returns a constant: \'list.seq\'' do
				expect(TypeListSeq.name).to eq 'list.seq'
			end
		end

		describe '.escape?' do
			it 'returns false' do
				expect(TypeListSeq.new.escape? @column1).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeListSeq.new.nested? @column1).to be true
			end
		end

	end

	describe TypeListRand do

		describe '.value' do
			before(:each) do
				@out_context = OutContext.new
				@out_context.count=4
				columns = Columns.new
				@out_context.columns = columns

				nested1 = Column.new("nest1", TypeConst.name, "0", { "value" => "value1"}, nil, @out_context)
				nested2 = Column.new("nest2", TypeConst.name, "0", { "value" => "value2"}, nil, @out_context)
				@column1 = Column.new("name1", TypeListRand.name, "0", nil, [ nested1, nested2 ] , @out_context)
				columns.columns = [ @column1 ]
			end

			it 'returns nested column values sequentially' do
				3.times do
					expect(['value1', 'value2'].include? TypeListRand.new.value @column1).to be true
					@out_context.shift_row
				end
			end
		end

		describe '.name' do
			it 'returns a constant: \'list.rand\'' do
				expect(TypeListRand.name).to eq 'list.rand'
			end
		end

		describe '.escape?' do
			it 'returns false' do
				expect(TypeListSeq.new.escape? @column1).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeListSeq.new.nested? @column1).to be true
			end
		end

	end

end
