class Nagare::Adapters::Hal < Nagare::Adapter
  def as_json(options = nil)
    if collection
      json = metadata(serializer).merge(serializer.attributes)
      json["_embedded"] = {}
      json["_embedded"][serializer.key] = serializer.map do |item_serializer|
        metadata(item_serializer).merge(item_serializer.attributes)
      end
      json
    else
      metadata(serializer).merge(serializer.attributes)
    end
  end

  private

  def metadata(serializer)
    links = serializer.links.reduce({}) do |links, link|
      if link.fetch(:extra).fetch(:array, false)
        links[link[:rel]] ||= []
        links[link[:rel]] << link[:extra].except(:array).merge({ href: serializer.send(:instance_eval, &link[:block]) })
        links
      else
        links.merge({
          link[:rel] => link[:extra].merge({ href: serializer.send(:instance_eval, &link[:block]) }),
        })
      end
    end

    links["self"] = {
      :href => serializer.href,
    }

    {
      "_links" => links,
    }
  end
end
