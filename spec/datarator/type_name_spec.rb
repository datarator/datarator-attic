require 'spec_helper'
require 'datarator/type_name'

module Datarator
	describe TypeNameName do

		describe '.value' do
			it 'returns name' do
				expect(TypeNameName.new.value nil).to match(/^[-'. a-zA-Z]+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'name.name\'' do
				expect(TypeNameName.name).to eq 'name.name'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeNameName.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeNameName.new.nested?).to be false
			end
		end

	end

	describe TypeNameFirstName do

		describe '.value' do
			it 'returns first name' do
				expect(TypeNameFirstName.new.value nil).to match(/^[- a-zA-Z]+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'name.first_name\'' do
				expect(TypeNameFirstName.name).to eq 'name.first_name'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeNameFirstName.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeNameFirstName.new.nested?).to be false
			end
		end
	end

	describe TypeNameLastName do

		describe '.value' do
			it 'returns last name' do
				expect(TypeNameLastName.new.value nil).to match(/^[-'. a-zA-Z]+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'name.last_name\'' do
				expect(TypeNameLastName.name).to eq 'name.last_name'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeNameLastName.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeNameLastName.new.nested?).to be false
			end
		end
	end

	describe TypeNamePrefix do

		describe '.value' do
			it 'returns the name "prefix"' do
				expect(TypeNamePrefix.new.value nil).to match(/^[-'. a-zA-Z]+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'name.prefix\'' do
				expect(TypeNamePrefix.name).to eq 'name.prefix'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeNamePrefix.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeNamePrefix.new.nested?).to be false
			end
		end
	end

	describe TypeNameSuffix do

		describe '.value' do
			it 'returns the name "suffix"' do
				expect(TypeNameSuffix.new.value nil).to match(/^[-'. a-zA-Z]+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'name.suffix\'' do
				expect(TypeNameSuffix.name).to eq 'name.suffix'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeNameSuffix.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeNameSuffix.new.nested?).to be false
			end
		end
	end

	describe TypeNameTitle do

		describe '.value' do
			it 'returns the name title' do
				expect(TypeNameTitle.new.value nil).to match(/^[-'. a-zA-Z]+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'name.title\'' do
				expect(TypeNameTitle.name).to eq 'name.title'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeNameTitle.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeNameTitle.new.nested?).to be false
			end
		end
	end

end
