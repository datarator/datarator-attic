require 'yaml'
require 'liquid'

module Datarator

	class OutTemplate
		def pre (out_context)
			raise NotImplementedError
		end

		def item (out_context)
			raise NotImplementedError
		end

		def post (out_context)
			raise NotImplementedError
		end

		def empty (out_context)
			raise NotImplementedError
		end

		def options
			[]
		end

		# def initialize (template)
		# 	yaml = YAML.load_file("lib/out_template/#{template}.yml")
		# 	@pre = Liquid::Template.parse(yaml['pre'])
		# 	@item = Liquid::Template.parse(yaml['item'])
		# 	@post = Liquid::Template.parse(yaml['post'])
		# 	@empty = Liquid::Template.parse(yaml['empty'])
		# end
                #
		# def pre (out_context)
		# 	@pre.render('context' => out_context)
		# end
                #
		# def item (out_context)
		# 	@item.render('context' => out_context)
		# end
                #
		# def post (out_context)
		# 	@post.render('context' => out_context)
		# end
                #
		# def empty
		# 	@empty.render('context' => out_context)
		# end
	end
end
