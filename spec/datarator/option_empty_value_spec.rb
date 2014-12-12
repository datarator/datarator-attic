require 'spec_helper'
require 'datarator/option_copy_from'

module Datarator
	describe OptionEmptyValue do

		describe '.name' do
			it 'returns a constant: \'empty_value\'' do
				expect(OptionEmptyValue.name).to eq 'empty_value'
			end
		end

		describe '.mandatory?' do
			it 'returns false' do
				expect(OptionEmptyValue.new.mandatory?).to be false
			end
		end

		describe '.boolean?' do
			it 'returns false' do
				expect(OptionEmptyValue.new.boolean?).to be false
			end
		end

	end
end
