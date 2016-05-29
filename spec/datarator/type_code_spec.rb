require 'spec_helper'
require 'datarator/type_bitcoin'

module Datarator
  describe TypeCodeEan do
    describe '.value' do
      it 'returns ean code' do
        expect(TypeCodeEan.new.value(nil)).to match(/^[0-9]+$/)
      end
    end

    describe '.name' do
      it 'returns a constant: \'code.ean\'' do
        expect(TypeCodeEan.name).to eq 'code.ean'
      end
    end

    describe '.escape?' do
      it 'returns true' do
        expect(TypeCodeEan.new.escape?(nil)).to be true
      end
    end

    describe '.nested?' do
      it 'returns false' do
        expect(TypeCodeEan.new.nested?).to be false
      end
    end
  end

  describe TypeCodeIsbn do
    describe '.value' do
      it 'returns isbn code' do
        expect(TypeCodeIsbn.new.value(nil)).to match(/^[A-Z0-9-]+$/)
      end
    end

    describe '.name' do
      it 'returns a constant: \'code.isbn\'' do
        expect(TypeCodeIsbn.name).to eq 'code.isbn'
      end
    end

    describe '.escape?' do
      it 'returns true' do
        expect(TypeCodeIsbn.new.escape?(nil)).to be true
      end
    end

    describe '.nested?' do
      it 'returns false' do
        expect(TypeCodeIsbn.new.nested?).to be false
      end
    end
  end
end
