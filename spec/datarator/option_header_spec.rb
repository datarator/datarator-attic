require 'spec_helper'
require 'datarator/option_header'

module Datarator
	describe OptionHeader do

		describe '.name' do
			it 'returns a constant: \'header\'' do
				expect(OptionHeader.name).to eq 'header'
			end
		end

		describe '.mandatory?' do
			it 'returns false' do
				expect(OptionHeader.new.mandatory?).to be false
			end
		end

		describe '.boolean?' do
			it 'returns true' do
				expect(OptionHeader.new.boolean?).to be true
			end
		end

	end
end
