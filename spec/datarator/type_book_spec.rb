require 'spec_helper'
require 'datarator/type_book'

module Datarator
	describe TypeBookName do

		describe '.value' do
			it 'returns book name' do
				expect(TypeBookName.new.value nil).to match(/^.+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'book.name\'' do
				expect(TypeBookName.name).to eq 'book.name'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeBookName.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeBookName.new.nested?).to be false
			end
		end

	end

	describe TypeBookPublisher do

		describe '.value' do
			it 'returns book publisher' do
				expect(TypeBookPublisher.new.value nil).to match(/^.+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'book.publisher\'' do
				expect(TypeBookPublisher.name).to eq 'book.publisher'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeBookPublisher.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeBookPublisher.new.nested?).to be false
			end
		end

	end

	describe TypeBookGenre do

		describe '.value' do
			it 'returns book genre' do
				expect(TypeBookGenre.new.value nil).to match(/^[-\sa-zA-Z0-9\/]+$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'book.genre\'' do
				expect(TypeBookGenre.name).to eq 'book.genre'
			end
		end

		describe '.escape?' do
			it 'returns true' do
				expect(TypeBookGenre.new.escape? nil).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeBookGenre.new.nested?).to be false
			end
		end

	end
end
