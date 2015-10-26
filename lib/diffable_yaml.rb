require 'psych'

require 'diffable_yaml/version'

module DiffableYAML
  # this dumps YAML with hashes / dicts in a consistent order so that
  # text diffs make more sense
  class DiffableYAMLTree < Psych::Visitors::YAMLTree
    def self.create options = {}, emitter = nil
      preorder = options.delete(:preorder) || []
      instance = Psych::Visitors::YAMLTree.create options, emitter
      instance.instance_variable_set '@preorder', preorder
      instance
    end

    def visit_Hash o
      tag      = o.class == ::Hash ? nil : "!ruby/hash:#{o.class}"
      implicit = !tag

      register(o, @emitter.start_mapping( nil, 
                                          tag, 
                                          implicit, 
                                          Psych::Nodes::Mapping::BLOCK))

      @preorder.each do |key|
        if o.key? key
          accept key
          accept o[key]
        end
      end
      o.keys.map {|k|
        [k, k.to_s]
      }.sort {|(k_a, s_a), (k_b, s_b)|
        s_a <=> s_b
      }.each do |k, s|
        unless @preorder.include? k
          accept k
          accept o[k]
        end
      end

      @emitter.end_mapping
    end

    def visit_String o
      plain = false
      quote = false
      style = Psych::Nodes::Scalar::ANY

      if binary?(o)
        str   = [o].pack('m').chomp
        tag   = '!binary' # FIXME: change to below when syck is removed
        #tag   = 'tag:yaml.org,2002:binary'
        style = Psych::Nodes::Scalar::LITERAL
      else
        str   = o
        tag   = nil
        quote = !(String === @ss.tokenize(o))
        plain = !quote
        if str.index("\n")
          style = Psych::Nodes::Scalar::LITERAL
        end
      end

      ivars = find_ivars o

      if ivars.empty?
        unless o.class == ::String
          tag = "!ruby/string:#{o.class}"
        end
        @emitter.scalar str, nil, tag, plain, quote, style
      else
        maptag = '!ruby/string'
        maptag << ":#{o.class}" unless o.class == ::String

        register o, @emitter.start_mapping( nil, 
                                            maptag, 
                                            false, 
                                            Pysch::Nodes::Mapping::BLOCK)
        @emitter.scalar 'str', 
                        nil, 
                        nil, 
                        true, 
                        false, 
                        Psych::Nodes::Scalar::ANY
        @emitter.scalar str, nil, tag, plain, quote, style

        dump_ivars o

        @emitter.end_mapping
      end
    end
  end

  def self.dump(o, io = nil, options = {})
    if Hash === io
      options = io
      io      = nil
    end

    visitor = DiffableYAMLTree.create options
    visitor << o
    visitor.tree.yaml io, options
  end
end