require 'spec_helper'
require 'datarator/type_copy'
require 'datarator/type_const'

module Datarator
  describe TypeCopy do
    before(:each) do
      @out_context = OutContext.new
      @out_context.count = 4

      columns = Columns.new
      @out_context.columns = columns

      @column1 = Column.new('name1', TypeConst.name, '0', { 'value' => 'value1' }, nil, @out_context)
      @column2 = Column.new('name2', TypeCopy.name, '0', { 'from' => 'name1' }, nil, @out_context)
      columns.columns = [@column1, @column2]
    end

    describe '.value' do
      it 'returns same value as referred column' do
        expect(@column1.value).to eq 'value1'
        expect(TypeCopy.new.value(@column2)).to eq 'value1'
      end
    end

    describe '.name' do
      it 'returns a constant: \'copy\'' do
        expect(TypeCopy.name).to eq 'copy'
      end
    end

    describe '.escape?' do
      it 'returns the same as referred column' do
        expect(TypeCopy.new.escape?(@column2)).to eq TypeConst.new.escape? @column1
      end
    end

    describe '.nested?' do
      it 'returns false' do
        expect(TypeCopy.new.nested?).to be false
      end
    end
  end
end
