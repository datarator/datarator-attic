require 'spec_helper'
require 'datarator/type_const'

module Datarator
	describe TypeConst do

		describe '.value' do
			before(:each) do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeConst.name, "0", { "value" => "foo_const"}, nil, out_context)
				columns.columns = [ @column ]
			end

			it 'returns constant value' do
				expect(TypeConst.new.value @column).to eq 'foo_const'
			end
		end

		describe '.name' do
			it 'returns a constant: \'const\'' do
				expect(TypeConst.name).to eq 'const'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeConst.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns true' do
				expect(TypeConst.new.nested? nil).to be false
			end
		end
	end
end
