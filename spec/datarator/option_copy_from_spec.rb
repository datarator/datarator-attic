require 'spec_helper'
require 'datarator/option_copy_from'

module Datarator
	describe OptionCopyFrom do

		describe '.name' do
			it 'returns a constant: \'from\'' do
				expect(OptionCopyFrom.name).to eq 'from'
			end
		end

		describe '.mandatory?' do
			it 'returns true' do
				expect(OptionCopyFrom.new.mandatory?).to be true
			end
		end

		describe '.boolean?' do
			it 'returns false' do
				expect(OptionCopyFrom.new.boolean?).to be false
			end
		end

	end
end
