require 'spec_helper'
require 'datarator/type_boolean'

module Datarator
  describe TypeBoolean do
    describe '.value' do
      it 'returns true for true ratio 1' do
        out_context = OutContext.new
        out_context.count = 1
        columns = Columns.new
        out_context.columns = columns

        @column = Column.new('name1', TypeBoolean.name, '0', { 'true_ratio' => '1' }, nil, out_context)
        columns.columns = [@column]

        expect(TypeBoolean.new.value(@column)).to be true
      end

      it 'returns false for true ratio 0' do
        out_context = OutContext.new
        out_context.count = 1
        columns = Columns.new
        out_context.columns = columns

        @column = Column.new('name1', TypeBoolean.name, '0', { 'true_ratio' => '0' }, nil, out_context)
        columns.columns = [@column]

        expect(TypeBoolean.new.value(@column)).to be false
      end

      it 'returns any boolean for true ratio 0.5' do
        out_context = OutContext.new
        out_context.count = 1
        columns = Columns.new
        out_context.columns = columns

        @column = Column.new('name1', TypeBoolean.name, '0', { 'true_ratio' => '0.5' }, nil, out_context)
        columns.columns = [@column]

        expect(TypeBoolean.new.value(@column)).to satisfy { |x| x == true || x == false }
      end
    end

    describe '.name' do
      it 'returns a constant: \'boolean\'' do
        expect(TypeBoolean.name).to eq 'boolean'
      end
    end

    describe '.escape?' do
      it 'returns false' do
        expect(TypeBoolean.new.nested?).to be false
      end
    end

    describe '.nested?' do
      it 'returns false' do
        expect(TypeBoolean.new.nested?).to be false
      end
    end
  end
end
