require_relative 'out_template'
require_relative 'out_template_csv'
require_relative 'out_template_sql'
require_relative 'out_template_liquibase'

module Datarator
  class OutTemplates
    TEMPLATES = {
      # 'csv' => OutTemplate.new('csv')
      OutTemplateCsv.name => OutTemplateCsv.new,
      OutTemplateSql.name => OutTemplateSql.new,

      OutTemplateLiquibaseXml.name => OutTemplateLiquibaseXml.new,
      OutTemplateLiquibaseYaml.name => OutTemplateLiquibaseYaml.new,
      OutTemplateLiquibaseJson.name => OutTemplateLiquibaseJson.new
    }.freeze

    class << self
      def validate(name)
        raise ArgumentError, "template not supported: #{name}" unless TEMPLATES.key?(name)
      end

      def pre(out_context)
        # raise "out_context must be of type OutContext" unless out_context.kind_of? OutContext
        TEMPLATES[out_context.template].pre(out_context)
      end

      def item(out_context)
        # TODO: ??? batch reder / ruby code for standard templates (for performance reasons)

        # raise "out_context must be of type OutContext" unless out_context.kind_of? OutContext
        TEMPLATES[out_context.template].item(out_context)
      end

      def post(out_context)
        # raise "out_context must be of type OutContext" unless out_context.kind_of? OutContext
        TEMPLATES[out_context.template].post(out_context)
      end

      def empty(out_context)
        # raise "out_context must be of type OutContext" unless out_context.kind_of? OutContext
        TEMPLATES[out_context.template].empty out_context
      end

      def find_all
        templates = []
        TEMPLATES.each do |key, template|
          options = []
          template.options.each do |option|
            options << { name: option.class.name, mandatory: option.mandatory?, boolean: option.boolean? }
          end

          templates << {
            name: key,
            group: template.group,
            options: options
          }
        end

        templates
      end

      def content_type(out_context)
        TEMPLATES[out_context.template].content_type
      end

      def file_ext(out_context)
        TEMPLATES[out_context.template].file_ext
      end

      def options(template)
        TEMPLATES[template].options
      end
    end
  end
end
