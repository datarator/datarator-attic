require_relative 'out_template'
require_relative 'out_context'

module Datarator

	class OutTemplateLiquibase < OutTemplate
		def group
			'liquibase'
		end

		def empty (out_context)
			'NULL'
		end

		def options
			OPTIONS
		end

		OPTIONS = [ OptionLiquibaseChangeset.new ]

	end

	# see: http://www.liquibase.org/documentation/xml_format.html
	class OutTemplateLiquibaseXml < OutTemplateLiquibase

		class << self
			def name
				"#{OutTemplateLiquibase.new.group}.xml"
			end
		end

		def pre (out_context)
			if Options.value(out_context.options, OptionLiquibaseChangeset.name)
				"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<databaseChangeLog\nxmlns=\"http://www.liquibase.org/xml/ns/dbchangelog\"\n  xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n  xsi:schemaLocation=\"http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.0.xsd\">\n\n  <changeset author=\"datarator.io\" id=\"#{out_context.document}-#{Time.now.to_i}\">\n"
			else
				''
			end
		end

		def item (out_context)
			values = values out_context
			names = names out_context

			cols = (
				(0..names.length-1).map do | index |
					"      <column name=\"#{names[index]}\" value=\"#{values[index]}\"/>"
				end
			)

			"    <insert tableName=\"#{out_context.document}\">\n#{cols.join("\n")}\n    </insert>\n"
		end

		def post (out_context)
			if Options.value(out_context.options, OptionLiquibaseChangeset.name)
				"  </changeset>\n</databaseChangeLog>"
			else
				''
			end
		end

		def empty (out_context)
			'NULL'
		end

		def content_type
			'text/xml'
		end

		def file_ext
			'xml'
		end
	end

	# sample http://forum.liquibase.org/topic/how-to-specify-rollback-in-yaml-changelog-file
	class OutTemplateLiquibaseYaml < OutTemplateLiquibase

		class << self
			def name
				"#{OutTemplateLiquibase.new.group}.yaml"
			end
		end

		def pre (out_context)
			if Options.value(out_context.options, OptionLiquibaseChangeset.name)
				"databaseChangeLog:\n  - changeset\n      author: datarator.io\n      id: #{out_context.document}-#{Time.now.to_i}\n      changes:\n"
			else
				''
			end
		end

		def item (out_context)
			values = values out_context
			names = names out_context

			cols = (
				(0..names.length-1).map do | index |
					"              - column:\n                  name: #{names[index]}\n                  value: #{values[index]}"
				end
			)

			"        - insert:\n            tableName: #{out_context.document}\n            columns:\n#{cols.join("\n")}\n"
		end

		def post (out_context)
			''
		end

		def content_type
			'application/x-yaml'
		end

		def file_ext
			'yaml'
		end
	end

	# see: http://www.liquibase.org/documentation/json_format.html
	class OutTemplateLiquibaseJson < OutTemplateLiquibase

		class << self
			def name
				"#{OutTemplateLiquibase.new.group}.json"
			end
		end

		def pre (out_context)
			if Options.value(out_context.options, OptionLiquibaseChangeset.name)
				"{\n    databaseChangeLog: [\n        {\n           \"changeset\"\n                \"author\": \"datarator.io\"\n                \"id\": #{out_context.document}-#{Time.now.to_i}\"\n                \"changes\": [\n                    {\n"
			else
				''
			end
		end

		def item (out_context)
			values = values out_context
			names = names out_context

			cols = (
				(0..names.length-1).map do | index |
					"                                    \"column\": {\n                                        \"name\": \"#{names[index]}\",\n                                        \"value\": \"#{values[index]}\"\n                                        }"
				end
			)

			"                        \"insert\": {\n                            \"tableName\": \"#{out_context.document}\",\n                            \"columns\" [\n                                {\n#{cols.join(",\n")}\n                                    }#{out_context.row_index == out_context.count ? '' : ','}\n                            ]\n                        }\n"
		end

		def post (out_context)
			if Options.value(out_context.options, OptionLiquibaseChangeset.name)
				"                    }\n                ]\n            }\n        ]\n}"
			else
				''
			end
		end

		def content_type
			'application/json'
		end

		def file_ext
			'json'
		end
	end
end
