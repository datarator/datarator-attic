require_relative 'out_template'
require_relative 'out_context'

module Datarator
  class OutTemplateSql < OutTemplate
    class << self
      def name
        'sql'
      end
    end

    def pre(_out_context)
      ''
    end

    def item(out_context)
      values = (
        out_context.columns.map_shallow do |column|
          value = column.value

          # escaping character: '
          value = value.gsub(/'/, "''") if value.is_a? String

          # escaping values that need escaping based on type
          value = "'#{value}'" if column.escape

          value
        end
      )

      prefix = out_context.cache['sql_prefix']
      if prefix.nil?
        names = names(out_context)
        prefix = "INSERT INTO #{out_context.document} (#{names.join(',')}) VALUES ("
        out_context.cache['sql_prefix'] = prefix
      end

      suffix = ");\n"

      # "INSERT INTO #{out_context.document} (#{names.join(',')}) VALUES (#{values.join(',')});\n"
      "#{prefix}#{values.join(',')}#{suffix}"
    end

    def post(_out_context)
      ''
    end

    def empty(_out_context)
      'NULL'
    end

    def content_type
      'text/plain'
    end

    def file_ext
      'sql'
    end
  end
end
