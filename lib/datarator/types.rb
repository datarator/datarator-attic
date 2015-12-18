module Datarator
  class Types
    class << self
      def value(column)
        column.empty_index? ? column.out_context.empty_value : TYPES[column.type].value(column)
      end

      def supports?(name)
        TYPES.has_key?(name)
      end

      def validate(type)
        raise ArgumentError, 'type can\'t be empty' if type.nil? or type.empty?
        raise ArgumentError, "type not supported: #{type}" unless supports? type
      end

      def nested? (column)
        TYPES[column.type].nested?
      end

      def escape? (column)
        !column.empty_index? && TYPES[column.type].escape?(column)
      end

      def options (type)
        TYPES[type].options
      end

      def find_all ()
        types = []
        TYPES.each do |key, type|
          options = []
          type.options.each do |option|
            options << {:name => option.class.name, :mandatory => option.mandatory?, :boolean => option.boolean?}
          end

          types << {
              :name => type.class.name,
              :nested => type.nested?,
              :options => options
              # TODO :categories => [ "name", "string", "human", ... ]
          }
        end

        types
      end
    end

    require_relative 'type_const'
    require_relative 'type_row_index'
    require_relative 'type_copy'

    require_relative 'type_list'
    require_relative 'type_join'

    require_relative 'type_name'

    TYPES = {

        #
        # specific
        #
        TypeConst.name => TypeConst.new,
        TypeRowIndex.name => TypeRowIndex.new,
        TypeCopy.name => TypeCopy.new,

        #
        # nested columns
        #
        TypeListSeq.name => TypeListSeq.new,
        TypeListRand.name => TypeListRand.new,
        TypeJoin.name => TypeJoin.new,

        #
        # faker
        #

        # name
        TypeNameName.name => TypeNameName.new,
        TypeNameFirstName.name => TypeNameFirstName.new,
        TypeNameLastName.name => TypeNameLastName.new,
        TypeNamePrefix.name => TypeNamePrefix.new,
        TypeNameSuffix.name => TypeNameSuffix.new,
        TypeNameTitle.name => TypeNameTitle.new
    }
  end
end
