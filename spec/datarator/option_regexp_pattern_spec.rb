require 'spec_helper'
require 'datarator/option_regexp_pattern'

module Datarator
  describe OptionRegexpPattern do
    describe '.name' do
      it 'returns a constant: \'pattern\'' do
        expect(OptionRegexpPattern.name).to eq 'pattern'
      end
    end

    describe '.mandatory?' do
      it 'returns true' do
        expect(OptionRegexpPattern.new.mandatory?).to be true
      end
    end

    describe '.boolean?' do
      it 'returns false' do
        expect(OptionRegexpPattern.new.boolean?).to be false
      end
    end
  end
end
