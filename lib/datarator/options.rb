require_relative 'option'

module Datarator
	class Options

		class << self

			def option (name)
				opt = OPTIONS[name]
				raise ArgumentError, "option: #{name} is unknown" if opt.nil?
				opt
			end

			def value (options, name)
				opt = option name
				if !opt.mandatory? && (options.nil? || options[name].nil?)
					if opt.boolean?
						return false
					else
						return ''
					end
				end

				if opt.boolean?
					return options[name] == true || options[name].is_a?(String) && options[name].downcase == 'true'
				end

				options[name]
			end
		end

		require_relative 'option_header'
		require_relative 'option_liquibase_changeset'
		require_relative 'option_empty_value'

		require_relative 'option_const_value'
		require_relative 'option_copy_from'
		require_relative 'option_join_separator'

		OPTIONS = {
			# template
			OptionHeader.name => OptionHeader.new,
			OptionLiquibaseChangeset.name => OptionLiquibaseChangeset.new,
			OptionEmptyValue.name => OptionEmptyValue.new,

			# type
			OptionConstValue.name => OptionConstValue.new,
			OptionCopyFrom.name => OptionCopyFrom.new,
			OptionJoinSeparator.name => OptionJoinSeparator.new
		}
	end
end
