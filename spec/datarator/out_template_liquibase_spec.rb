require 'spec_helper'
require 'datarator/out_template_liquibase'
require 'datarator/type_name'

module Datarator
	describe OutTemplateLiquibaseXml do
		before(:each) do
			@out_context = OutContext.new
			@out_context.document = 'table1'
			@out_context.count = 1
			@out_context.template = 'liquibase.xml'

			columns = Columns.new
			@out_context.columns = columns
			column1 = Column.new("name1", TypeConst.name, "0", { "value" => "value1"} , nil, @out_context)
			column2 = Column.new("name2", TypeConst.name, "0", { "value" => "value2"}, nil, @out_context)
			columns.columns = [ column1, column2 ]
		end

		describe '.name' do
			it 'returns a constant: \'liquibase.xml\'' do
				expect( OutTemplateLiquibaseXml.name ).to eq 'liquibase.xml'
			end
		end

		describe '.group' do
			it 'returns a constant: \'liquibase\'' do
				expect( OutTemplateLiquibaseXml.new.group ).to eq 'liquibase'
			end
		end

		describe '.pre' do
			context 'having changeset explicitly disabled' do
				it 'returns empty string' do
					@out_context.options = { 'changeset' => 'false' }
					expect(OutTemplateLiquibaseXml.new.pre @out_context).to eq ''
				end
			end

			context 'having changeset implicitly disabled' do
				it 'returns empty string' do
					expect(OutTemplateLiquibaseXml.new.pre @out_context).to eq ''
				end
			end

			context 'having changeset enabled' do
				it 'returns xml root with schemas' do
					@out_context.options = { 'changeset' => 'true' }
					expect(OutTemplateLiquibaseXml.new.pre @out_context).to start_with "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<databaseChangeLog\nxmlns=\"http://www.liquibase.org/xml/ns/dbchangelog\"\n"
				end
			end
		end

		describe '.item' do
			it 'returns xml-formatted liquibase changeset values' do
				expect(OutTemplateLiquibaseXml.new.item @out_context).to eq "    <insert tableName=\"table1\">\n      <column name=\"name1\" value=\"value1\"/>\n      <column name=\"name2\" value=\"value2\"/>\n    </insert>\n"
			end
		end

		describe '.post' do
			context 'having changeset explicitly disabled' do
				it 'returns empty string' do
					@out_context.options = { 'changeset' => 'false' }
					expect(OutTemplateLiquibaseXml.new.post @out_context).to eq ''
				end
			end

			context 'having changeset implicitly disabled' do
				it 'returns empty string' do
					expect(OutTemplateLiquibaseXml.new.post @out_context).to eq ''
				end
			end

			context 'having changeset enabled' do
				it 'returns xml root with schemas' do
					@out_context.options = { 'changeset' => 'true' }
					expect(OutTemplateLiquibaseXml.new.post @out_context).to eq "  </changeset>\n</databaseChangeLog>"
				end
			end
		end

		describe '.empty' do
			it 'returns empty string' do
				expect(OutTemplateLiquibaseXml.new.empty @out_context).to eq 'NULL'
			end
		end

		describe '.options' do
			it 'returns changeset option' do
				expect( OutTemplateLiquibaseXml.new.options ).to match_array([ OptionLiquibaseChangeset.new ])
			end
		end

		describe '.content_type' do
			it 'returns xml mime type' do
				expect(OutTemplateLiquibaseXml.new.content_type ).to eq 'text/xml'
			end
		end

		describe '.file_ext' do
			it 'returns xml' do
				expect( OutTemplateLiquibaseXml.new.file_ext ).to eq 'xml'
			end
		end
	end

	describe OutTemplateLiquibaseYaml do
		before(:each) do
			@out_context = OutContext.new
			@out_context.document = 'table1'
			@out_context.count = 1
			@out_context.template = 'liquibase.yaml'

			columns = Columns.new
			@out_context.columns = columns
			column1 = Column.new("name1", TypeConst.name, "0", { "value" => "value1"} , nil, @out_context)
			column2 = Column.new("name2", TypeConst.name, "0", { "value" => "value2"}, nil, @out_context)
			columns.columns = [ column1, column2 ]
		end

		describe '.name' do
			it 'returns a constant: \'liquibase.yaml\'' do
				expect( OutTemplateLiquibaseYaml.name ).to eq 'liquibase.yaml'
			end
		end

		describe '.group' do
			it 'returns a constant: \'liquibase\'' do
				expect( OutTemplateLiquibaseYaml.new.group ).to eq 'liquibase'
			end
		end

		describe '.pre' do
			context 'having changeset explicitly disabled' do
				it 'returns empty string' do
					@out_context.options = { 'changeset' => 'false' }
					expect(OutTemplateLiquibaseYaml.new.pre @out_context).to eq ''
				end
			end

			context 'having changeset implicitly disabled' do
				it 'returns empty string' do
					expect(OutTemplateLiquibaseYaml.new.pre @out_context).to eq ''
				end
			end

			context 'having changeset enabled' do
				it 'returns xml root with schemas' do
					@out_context.options = { 'changeset' => 'true' }
					expect(OutTemplateLiquibaseYaml.new.pre @out_context).to start_with "databaseChangeLog:\n  - changeset\n      author: datarator.io\n      id: "
				end
			end
		end

		describe '.item' do
			it 'returns xml-formatted liquibase changeset values' do
				expect(OutTemplateLiquibaseYaml.new.item @out_context).to eq "        - insert:\n            tableName: table1\n            columns:\n              - column:\n                  name: name1\n                  value: value1\n              - column:\n                  name: name2\n                  value: value2\n"
			end
		end

		describe '.post' do
			it 'returns empty string' do
				expect(OutTemplateLiquibaseYaml.new.post @out_context).to eq ''
			end
		end


		describe '.empty' do
			it 'returns empty string' do
				expect(OutTemplateLiquibaseYaml.new.empty @out_context).to eq 'NULL'
			end
		end

		describe '.options' do
			it 'returns changeset option' do
				expect( OutTemplateLiquibaseYaml.new.options ).to match_array([ OptionLiquibaseChangeset.new ])
			end
		end

		describe '.content_type' do
			it 'returns yaml mime type' do
				expect(OutTemplateLiquibaseYaml.new.content_type ).to eq 'application/x-yaml'
			end
		end

		describe '.file_ext' do
			it 'returns yaml' do
				expect( OutTemplateLiquibaseYaml.new.file_ext ).to eq 'yaml'
			end
		end
	end

	describe OutTemplateLiquibaseJson do
		before(:each) do
			@out_context = OutContext.new
			@out_context.document = 'table1'
			@out_context.count = 1
			@out_context.template = 'liquibase.json'

			columns = Columns.new
			@out_context.columns = columns
			column1 = Column.new("name1", TypeConst.name, "0", { "value" => "value1"} , nil, @out_context)
			column2 = Column.new("name2", TypeConst.name, "0", { "value" => "value2"}, nil, @out_context)
			columns.columns = [ column1, column2 ]
		end

		describe '.name' do
			it 'returns a constant: \'liquibase.json\'' do
				expect( OutTemplateLiquibaseJson.name ).to eq 'liquibase.json'
			end
		end

		describe '.group' do
			it 'returns a constant: \'liquibase\'' do
				expect( OutTemplateLiquibaseJson.new.group ).to eq 'liquibase'
			end
		end

		describe '.pre' do
			context 'having changeset explicitly disabled' do
				it 'returns empty string' do
					@out_context.options = { 'changeset' => 'false' }
					expect(OutTemplateLiquibaseJson.new.pre @out_context).to eq ''
				end
			end

			context 'having changeset implicitly disabled' do
				it 'returns empty string' do
					expect(OutTemplateLiquibaseJson.new.pre @out_context).to eq ''
				end
			end

			context 'having changeset enabled' do
				it 'returns xml root with schemas' do
					@out_context.options = { 'changeset' => 'true' }
					expect(OutTemplateLiquibaseJson.new.pre @out_context).to start_with "{\n    databaseChangeLog: [\n        {\n           \"changeset\"\n                \"author\": \"datarator.io\"\n                \"id\":"
				end
			end
		end

		describe '.item' do
			it 'returns xml-formatted liquibase changeset values' do
				expect(OutTemplateLiquibaseJson.new.item @out_context).to eq "                        \"insert\": {\n                            \"tableName\": \"table1\",\n                            \"columns\" [\n                                {\n                                    \"column\": {\n                                        \"name\": \"name1\",\n                                        \"value\": \"value1\"\n                                        },\n                                    \"column\": {\n                                        \"name\": \"name2\",\n                                        \"value\": \"value2\"\n                                        }\n                                    },\n                            ]\n                        }\n"
			end
		end

		describe '.post' do
			it 'returns empty string' do
				expect(OutTemplateLiquibaseJson.new.post @out_context).to eq ''
			end
		end


		describe '.empty' do
			it 'returns empty string' do
				expect(OutTemplateLiquibaseJson.new.empty @out_context).to eq 'NULL'
			end
		end

		describe '.options' do
			it 'returns changeset option' do
				expect( OutTemplateLiquibaseJson.new.options ).to match_array([ OptionLiquibaseChangeset.new ])
			end
		end

		describe '.content_type' do
			it 'returns yaml mime type' do
				expect(OutTemplateLiquibaseJson.new.content_type ).to eq 'application/json'
			end
		end

		describe '.file_ext' do
			it 'returns json' do
				expect( OutTemplateLiquibaseJson.new.file_ext ).to eq 'json'
			end
		end
	end

end
