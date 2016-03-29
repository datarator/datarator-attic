require 'spec_helper'
require 'datarator/type_credit_card'

module Datarator
	describe TypeCreditCardNumber do

		describe '.value' do
			it 'returns credit card number' do
				expect(TypeCreditCardNumber.new.value nil).to match(/^[0-9]{4}(-[0-9]{4}){3}$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'credit_card.number\'' do
				expect(TypeCreditCardNumber.name).to eq 'credit_card.number'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeCreditCardNumber.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeCreditCardNumber.new.nested?).to be false
			end
		end

	end

	describe TypeCreditCardType do

		describe '.value' do
			it 'returns credit card type' do
				expect(TypeCreditCardType.new.value nil).to match(/^[a-zA-Z-]+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'credit_card.type\'' do
				expect(TypeCreditCardType.name).to eq 'credit_card.type'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeCreditCardType.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeCreditCardType.new.nested?).to be false
			end
		end
	end
end
