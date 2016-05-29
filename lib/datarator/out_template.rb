require 'yaml'
# require 'liquid'

module Datarator
  class OutTemplate
    def pre(_out_context)
      raise NotImplementedError
    end

    def item(_out_context)
      raise NotImplementedError
    end

    def post(_out_context)
      raise NotImplementedError
    end

    def empty(_out_context)
      raise NotImplementedError
    end

    def content_type
      raise NotImplementedError
    end

    def file_ext
      raise NotImplementedError
    end

    def group
      ''
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

    # TODO: ??? unit tests

    protected

    def values(out_context)
      out_context.columns.map_shallow(&:value)
    end

    # TODO: ??? unit tests

    protected

    def names(out_context)
      names = out_context.cache['out_names']
      if names.nil?
        names = out_context.columns.map_shallow(&:name)
        out_context.cache['out_names'] = names
      end
      names
    end
  end
end
