require 'spec_helper'
require 'datarator/option'

module Datarator
  describe Option do
    describe '.mandatory?' do
      it 'raises NotImplementedError' do
        expect { Option.new.mandatory? }.to raise_error(NotImplementedError)
      end
    end

    describe '.boolean?' do
      it 'raises NotImplementedError' do
        expect { Option.new.boolean? }.to raise_error(NotImplementedError)
      end
    end
  end
end
