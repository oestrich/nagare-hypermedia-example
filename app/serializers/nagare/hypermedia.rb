module Nagare::Hypermedia
  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def key(key = nil)
      return @key unless key
      @key = key
    end

    def href(&block)
      return @href unless block_given?
      @href = block
    end

    def links
      @links ||= []
    end

    def link(rel, extra = {}, &block)
      links << { rel: rel, extra: extra, block: block }
    end
  end

  def links
    self.class.links
  end

  def key
    self.class.key
  end

  def href
    href = self.class.href
    return unless href
    instance_eval(&href)
  end
end
