
module Datarator
  class Option
    def mandatory?
      raise NotImplementedError
    end

    def boolean?
      raise NotImplementedError
    end

    def ==(other)
      self.class.name == other.class.name && mandatory? == other.mandatory? && boolean? == other.boolean?
    end
  end
end
