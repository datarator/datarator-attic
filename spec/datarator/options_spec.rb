require 'spec_helper'
require 'datarator/options'

module Datarator
	describe Options do

		describe '.option' do
				it 'returns option for known option name' do
					expect(Options.option(OptionHeader.name)).to be_a(OptionHeader)
				end

				it 'raises error for unknown option name' do
					expect{ Options.name('non_existing') }.to raise_error(ArgumentError)
				end
		end

		describe '.value' do
			context 'having optional boolean option explicitly false' do
				it 'sets to false' do
					expect(Options.value({ 'header' => 'false'}, OptionHeader.name)).to be false
					expect(Options.value({ 'header' => 'False'}, OptionHeader.name)).to be false
					expect(Options.value({ 'header' => 'FALSE'}, OptionHeader.name)).to be false
					expect(Options.value({ 'header' => false}, OptionHeader.name)).to be false
				end
			end

			context 'having optional boolean option explicitly true' do
				it 'sets to true' do
					expect(Options.value({ 'header' => 'true'}, OptionHeader.name)).to be true
					expect(Options.value({ 'header' => 'True'}, OptionHeader.name)).to be true
					expect(Options.value({ 'header' => 'TRUE'}, OptionHeader.name)).to be true
					expect(Options.value({ 'header' => true}, OptionHeader.name)).to be true
				end
			end

			context 'having optional boolean option not explicitly set' do
				it 'sets to false' do
					expect(Options.value(nil, OptionHeader.name)).to be false
					expect(Options.value({}, OptionHeader.name)).to be false
					expect(Options.value({ 'other_option' => 'aaa' }, OptionHeader.name)).to be false
				end
			end

			context 'having mandatory string option explicitly set' do
				it 'sets to value set' do
					expect(Options.value({ 'value' => 'foo'}, OptionConstValue.name)).to eq 'foo'
				end
			end

			context 'having optional string option explicitly set' do
				it 'sets to value set' do
					expect(Options.value({ 'separator' => ','}, OptionJoinSeparator.name)).to eq ','
				end
			end


			context 'having optional string option not explicitly set' do
				it 'sets to \'\'' do
					expect(Options.value(nil, OptionJoinSeparator.name)).to eq ''
					expect(Options.value({}, OptionJoinSeparator.name)).to eq ''
					expect(Options.value({ 'other_option' => 'aaa' }, OptionJoinSeparator.name)).to eq ''
				end
			end
		end
	end
end
