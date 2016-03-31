require 'spec_helper'
require 'datarator/option_escape'

module Datarator
	describe OptionEscape do

		describe '.name' do
			it 'returns a constant: \'escape\'' do
				expect(OptionEscape.name).to eq 'escape'
			end
		end

		describe '.mandatory?' do
			it 'returns false' do
				expect(OptionEscape.new.mandatory?).to be false
			end
		end

		describe '.boolean?' do
			it 'returns true' do
				expect(OptionEscape.new.boolean?).to be true
			end
		end

	end
end
