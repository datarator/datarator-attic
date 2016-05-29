require 'spec_helper'
require 'datarator/option_boolean_true_ratio'

module Datarator
  describe OptionBooleanTrueRatio do
    describe '.name' do
      it 'returns a constant: \'true_ratio\'' do
        expect(OptionBooleanTrueRatio.name).to eq 'true_ratio'
      end
    end

    describe '.mandatory?' do
      it 'returns false' do
        expect(OptionBooleanTrueRatio.new.mandatory?).to be false
      end
    end

    describe '.boolean?' do
      it 'returns true' do
        expect(OptionBooleanTrueRatio.new.boolean?).to be false
      end
    end
  end
end
