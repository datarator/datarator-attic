require 'spec_helper'
require 'datarator/type_const'

module Datarator
	describe TypeConst do

		describe '.value' do
			before(:each) do
				in_params = InParams.new
				in_params.document = 'table1'
				options = Hash.new
				options[TypeConst.name] = 'foo_const'
				in_params.columns = [ Column.new("name1", TypeConst.name, "0", options )]
				in_params.count = 1
				in_params.template = 'csv'
				@out_context = OutContext.new in_params
			end

			it 'returns constant value' do
				expect(TypeConst.new.value @out_context ).to eq 'foo_const'
			end
		end

		describe '.name' do
			it 'returns a constant: \'const\'' do
				expect(TypeConst.name).to eq 'const'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeConst.new.escape?).to eq true
			end
		end
	end
end
