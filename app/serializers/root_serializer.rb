class RootSerializer < Nagare::Item
  attributes :_links

  def _links
    {
      self: { href: "/" },
    }
  end
end
