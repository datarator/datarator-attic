require 'spec_helper'
require 'datarator/option_join_separator'

module Datarator
	describe OptionJoinSeparator do

		describe '.name' do
			it 'returns a constant: \'separator\'' do
				expect(OptionJoinSeparator.name).to eq 'separator'
			end
		end

		describe '.mandatory?' do
			it 'returns false' do
				expect(OptionJoinSeparator.new.mandatory?).to be false
			end
		end

		describe '.boolean?' do
			it 'returns false' do
				expect(OptionJoinSeparator.new.boolean?).to be false
			end
		end

	end
end
