require_relative 'type.rb'
require 'faker'

module Datarator
  class TypeColor < Type
    class << self
      def name
        'color'
      end
    end

    def escape?(_column)
      true
    end

    def nested?
      false
    end
  end

  class TypeColorHex < TypeColor
    class << self
      def name
        "#{TypeColor.name}.hex"
      end
    end

    def value(_column)
      Faker::Color.hex_color
    end
  end

  class TypeColorName < TypeColor
    class << self
      def name
        "#{TypeColor.name}.name"
      end
    end

    def value(_column)
      Faker::Color.color_name
    end
  end
end
