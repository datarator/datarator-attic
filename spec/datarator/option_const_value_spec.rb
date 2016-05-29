require 'spec_helper'
require 'datarator/option_const_value'

module Datarator
  describe OptionConstValue do
    describe '.name' do
      it 'returns a constant: \'value\'' do
        expect(OptionConstValue.name).to eq 'value'
      end
    end

    describe '.mandatory?' do
      it 'returns true' do
        expect(OptionConstValue.new.mandatory?).to be true
      end
    end

    describe '.boolean?' do
      it 'returns false' do
        expect(OptionConstValue.new.boolean?).to be false
      end
    end
  end
end
