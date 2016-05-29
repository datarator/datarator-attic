require_relative 'type'
require 'faker'

module Datarator
  class TypeCode < Type
    class << self
      def name
        'code'
      end
    end

    def escape?(_column)
      true
    end

    def nested?
      false
    end
  end

  class TypeCodeEan < TypeCode
    class << self
      def name
        "#{TypeCode.name}.ean"
      end
    end

    def value(_column)
      Faker::Code.ean
    end
  end

  class TypeCodeIsbn < TypeCode
    class << self
      def name
        "#{TypeCode.name}.isbn"
      end
    end

    def value(_column)
      Faker::Code.isbn
    end
  end
end
