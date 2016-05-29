require 'spec_helper'
require 'datarator/option_separator'

module Datarator
  describe OptionSeparator do
    describe '.name' do
      it 'returns a constant: \'separator\'' do
        expect(OptionSeparator.name).to eq 'separator'
      end
    end

    describe '.mandatory?' do
      it 'returns false' do
        expect(OptionSeparator.new.mandatory?).to be false
      end
    end

    describe '.boolean?' do
      it 'returns false' do
        expect(OptionSeparator.new.boolean?).to be false
      end
    end
  end
end
