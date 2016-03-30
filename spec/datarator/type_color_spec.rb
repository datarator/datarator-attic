require 'spec_helper'
require 'datarator/type_bitcoin'

module Datarator
	describe TypeColorHex do

		describe '.value' do
			it 'returns hex color' do
				expect(TypeColorHex.new.value nil).to match(/^#[0-9a-f]{6}$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'color,hex\'' do
				expect(TypeColorHex.name).to eq 'color.hex'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeColorHex.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeColorHex.new.nested?).to be false
			end
		end
	end

	describe TypeColorName do

		describe '.value' do
			it 'returns color name' do
				expect(TypeColorName.new.value nil).to match(/^[a-z ]+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'color.name\'' do
				expect(TypeColorName.name).to eq 'color.name'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeColorName.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeColorName.new.nested?).to be false
			end
		end
	end

end
