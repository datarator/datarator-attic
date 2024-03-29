require_relative 'option'

module Datarator
  class Options
    class << self
      def option(name)
        opt = OPTIONS[name]
        raise ArgumentError, "option: #{name} is unknown" if opt.nil?
        opt
      end

      def value(options, name)
        opt = option name
        return nil if !opt.mandatory? && (options.nil? || options[name].nil?)

        if opt.boolean?
          return options[name] == true || options[name].is_a?(String) && options[name].casecmp('true').zero?
        end

        options[name]
      end
    end

    require_relative 'option_header'
    require_relative 'option_liquibase_changeset'
    require_relative 'option_empty_value'

    require_relative 'option_boolean_true_ratio'
    require_relative 'option_const_value'
    require_relative 'option_copy_from'
    require_relative 'option_regexp_pattern'
    require_relative 'option_escape'
    require_relative 'option_number_max'
    require_relative 'option_number_min'

    require_relative 'option_separator'

    OPTIONS = {
      # template
      OptionHeader.name => OptionHeader.new,
      OptionLiquibaseChangeset.name => OptionLiquibaseChangeset.new,
      OptionEmptyValue.name => OptionEmptyValue.new,

      # type
      OptionBooleanTrueRatio.name => OptionBooleanTrueRatio.new,
      OptionConstValue.name => OptionConstValue.new,
      OptionCopyFrom.name => OptionCopyFrom.new,
      OptionRegexpPattern.name => OptionRegexpPattern.new,
      OptionEscape.name => OptionEscape.new,
      OptionNumberMax.name => OptionNumberMax.new,
      OptionNumberMin.name => OptionNumberMin.new,

      # mixed = template + type
      OptionSeparator.name => OptionSeparator.new
    }.freeze
  end
end
