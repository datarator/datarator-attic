require 'spec_helper'
require 'datarator/option_number_max'

module Datarator
  describe OptionNumberMax do
    describe '.name' do
      it 'returns a constant: \'min\'' do
        expect(OptionNumberMax.name).to eq 'max'
      end
    end

    describe '.mandatory?' do
      it 'returns true' do
        expect(OptionNumberMax.new.mandatory?).to be false
      end
    end

    describe '.boolean?' do
      it 'returns false' do
        expect(OptionNumberMax.new.boolean?).to be false
      end
    end
  end
end
