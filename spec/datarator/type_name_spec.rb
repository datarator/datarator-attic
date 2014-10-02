require 'spec_helper'
require 'datarator/type_name'

module Datarator
	describe TypeNameName do

		describe '.value' do
			it 'returns name' do
				expect(TypeNameName.new.value).to match(/^[-'. a-zA-Z]+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'name.name\'' do
				expect(TypeNameName.name).to eq 'name.name'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeNameFirstName.new.escape?).to eq true
			end
		end


	end

	describe TypeNameFirstName do

		describe '.value' do
			it 'returns first name' do
				expect(TypeNameFirstName.new.value).to match(/^[- a-zA-Z]+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'name.first_name\'' do
				expect(TypeNameFirstName.name).to eq 'name.first_name'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeNameFirstName.new.escape?).to eq true
			end
		end

	end
end
