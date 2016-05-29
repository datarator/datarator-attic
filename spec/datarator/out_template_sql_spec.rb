require 'spec_helper'
require 'datarator/out_template_sql'
require 'datarator/type_name'
require 'datarator/type_row_index'
require 'datarator/type_const'

module Datarator
  describe OutTemplates do
    before(:each) do
      @out_context = OutContext.new
      @out_context.document = 'table1'
      @out_context.count = 1
      # @out_context.template = 'sql'

      columns = Columns.new
      @out_context.columns = columns
      columns.columns = [Column.new('name1', TypeNameFirstName.name, '0', nil, nil, @out_context), Column.new('name2', TypeNameFirstName.name, '0', nil, nil, @out_context)]
    end

    describe '.name' do
      it 'returns a constant: \'sql\'' do
        expect(OutTemplateSql.name).to eq 'sql'
      end
    end

    describe '.group' do
      it 'returns empty group name' do
        expect(OutTemplateSql.new.group).to eq ''
      end
    end

    describe '.pre' do
      it 'returns empty string' do
        expect(OutTemplateSql.new.pre(@out_context)).to eq ''
      end
    end

    describe '.item' do
      it 'returns sql inserts with strings escaped' do
        columns = Columns.new
        @out_context.columns = columns
        column1 = Column.new('name1', TypeConst.name, '0', { 'value' => 'value1' }, nil, @out_context)
        column2 = Column.new('name2', TypeRowIndex.name, '0', nil, nil, @out_context)
        columns.columns = [column1, column2]

        expect(OutTemplateSql.new.item(@out_context)).to eq "INSERT INTO table1 (name1,name2) VALUES ('value1',0);\n"
      end

      it 'returns sql inserts with escaped character: \'' do
        columns = Columns.new
        @out_context.columns = columns
        column1 = Column.new('name1', TypeConst.name, '0', { 'value' => "foo'bar" }, nil, @out_context)
        columns.columns = [column1]

        expect(OutTemplateSql.new.item(@out_context)).to eq "INSERT INTO table1 (name1) VALUES ('foo\'\'bar');\n"
      end

      it 'returns sql inserts not-escaping NULLs' do
        columns = Columns.new
        @out_context.columns = columns
        columns.columns = [Column.new('name1', TypeConst.name, '100', { 'value' => 'value1' }, nil, @out_context)]
        @out_context.template = 'sql'

        expect(OutTemplateSql.new.item(@out_context)).to eq "INSERT INTO table1 (name1) VALUES (NULL);\n"
      end
    end

    describe '.post' do
      it 'returns empty string' do
        expect(OutTemplateSql.new.post(@out_context)).to eq ''
      end
    end

    describe '.empty' do
      it 'returns string: NULL' do
        expect(OutTemplateSql.new.empty(@out_context)).to eq 'NULL'
      end
    end

    describe '.options' do
      it 'returns no options' do
        expect(OutTemplateSql.new.options).to match_array([])
      end
    end

    describe '.content_type' do
      it 'returns text mime type' do
        expect(OutTemplateSql.new.content_type).to eq 'text/plain'
      end
    end

    describe '.file_ext' do
      it 'returns sql' do
        expect(OutTemplateSql.new.file_ext).to eq 'sql'
      end
    end
  end
end
