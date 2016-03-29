require 'spec_helper'
require 'datarator/type_bitcoin'

module Datarator
	describe BitcoinAddress do

		describe '.value' do
			it 'returns bitcoin address' do
				expect(BitcoinAddress.new.value nil).to match(/^[13]\S+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'bitcoin.address\'' do
				expect(BitcoinAddress.name).to eq 'bitcoin.address'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(BitcoinAddress.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(BitcoinAddress.new.nested?).to be false
			end
		end

	end
end
