module Datarator
  class Type
    def value(_column)
      raise NotImplementedError
    end

    def escape?(_column)
      raise NotImplementedError
    end

    # def validate(column)
    # 	raise NotImplementedError
    # end

    def nested?
      raise NotImplementedError
    end

    def options
      []
    end

    # def validate(column)
    # 	raise ArgumentError.new 'mandatory option not provided: ' if column.mandatory? AND column.options.nil? OR column.options[option.name].nil?
    # end

    # def option (options, option)
    # 	if !option.mandatory? AND options.nil? OR options[option.name].nil?
    # 		if option.boolean?
    # 			return false
    # 		else
    # 			return ''
    # 		end
    # 	end
    #
    # 	if option.boolean?
    # 		return options[option.name].downcase == 'true'
    # 	end
    #
    # 	options[option.name]
    # end
  end
end
