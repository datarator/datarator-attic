require_relative 'type'
require 'faker'

module Datarator
  class TypeName < Type
    class << self
      def name
        'name'
      end
    end

    def escape?(_column)
      true
    end

    def nested?
      false
    end
  end

  class TypeNameName < TypeName
    class << self
      def name
        "#{TypeName.name}.name"
      end
    end

    def value(_column)
      Faker::Name.name
    end
  end

  class TypeNameFirstName < TypeName
    class << self
      def name
        "#{TypeName.name}.first_name"
      end
    end

    def value(_column)
      Faker::Name.first_name
    end
  end

  class TypeNameLastName < TypeName
    class << self
      def name
        "#{TypeName.name}.last_name"
      end
    end

    def value(_column)
      Faker::Name.last_name
    end
  end

  class TypeNamePrefix < TypeName
    class << self
      def name
        "#{TypeName.name}.prefix"
      end
    end

    def value(_column)
      Faker::Name.prefix
    end
  end

  class TypeNameSuffix < TypeName
    class << self
      def name
        "#{TypeName.name}.suffix"
      end
    end

    def value(_column)
      Faker::Name.suffix
    end
  end

  class TypeNameTitle < TypeName
    class << self
      def name
        "#{TypeName.name}.title"
      end
    end

    def value(_column)
      Faker::Name.title
    end
  end
end
