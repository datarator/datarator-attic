require 'spec_helper'
require 'datarator/option_number_min'

module Datarator
  describe OptionNumberMin do
    describe '.name' do
      it 'returns a constant: \'min\'' do
        expect(OptionNumberMin.name).to eq 'min'
      end
    end

    describe '.mandatory?' do
      it 'returns true' do
        expect(OptionNumberMin.new.mandatory?).to be false
      end
    end

    describe '.boolean?' do
      it 'returns false' do
        expect(OptionNumberMin.new.boolean?).to be false
      end
    end
  end
end
