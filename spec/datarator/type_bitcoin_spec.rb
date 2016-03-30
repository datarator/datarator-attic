require 'spec_helper'
require 'datarator/type_bitcoin'

module Datarator
	describe TypeBitcoinAddress do

		describe '.value' do
			it 'returns bitcoin address' do
				expect(TypeBitcoinAddress.new.value nil).to match(/^[13]\S+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'bitcoin.address\'' do
				expect(TypeBitcoinAddress.name).to eq 'bitcoin.address'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeBitcoinAddress.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeBitcoinAddress.new.nested?).to be false
			end
		end

	end
end
