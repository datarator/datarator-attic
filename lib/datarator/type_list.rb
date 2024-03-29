require_relative 'type'

module Datarator
  class TypeList < Type
    class << self
      def name
        'list'
      end
    end

    def escape?(_column)
      true
    end

    def nested?
      true
    end

    # TODO: validate
    # make sure to have non-zero length nested array, otherwise division by zero in value method
  end

  class TypeListSeq < TypeList
    class << self
      def name
        "#{TypeList.name}.seq"
      end
    end

    def value(column)
      column.nested[column.out_context.row_index % column.nested.length].value
    end
  end

  class TypeListRand < TypeList
    class << self
      def name
        "#{TypeList.name}.rand"
      end
    end

    def value(column)
      column.nested[rand(column.nested.length)].value
    end
  end
end
