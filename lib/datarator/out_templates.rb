require 'datarator/out_template'

module Datarator

	class OutTemplates

		TEMPLATES = {
			'csv' => OutTemplate.new('csv')
		}

		class << self
			def validate(name)
				raise "template not supported: #{name}" unless TEMPLATES.has_key?(name)
			end

			def pre (out_context)
				# raise "out_context must be of type OutContext" unless out_context.kind_of? OutContext
				TEMPLATES[out_context.template].pre(out_context)
			end

			def item (out_context)
				# TODO ??? batch reder / ruby code for standard templates (for performance reasons)

				# raise "out_context must be of type OutContext" unless out_context.kind_of? OutContext
				TEMPLATES[out_context.template].item(out_context)
				# out_context.values.join(",") + "\n"
			end

			def post (out_context)
				# raise "out_context must be of type OutContext" unless out_context.kind_of? OutContext
				TEMPLATES[out_context.template].post(out_context)
			end

			def post (out_context)
				# raise "out_context must be of type OutContext" unless out_context.kind_of? OutContext
				TEMPLATES[out_context.template].post(out_context)
			end

			def empty (out_context)
				# raise "out_context must be of type OutContext" unless out_context.kind_of? OutContext
				TEMPLATES[out_context.template].empty(out_context)
			end
		end
	end
end

