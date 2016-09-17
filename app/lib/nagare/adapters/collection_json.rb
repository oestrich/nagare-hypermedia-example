class Nagare::Adapters::CollectionJson < Nagare::Adapter
  def as_json(options = nil)
    json = {
      "version" => "1.0",
      "href" => serializer.href,
      "links" => links(serializer.links),
    }

    if collection
      json["items"] = serializer.map do |item_serializer|
        {
          :href => item_serializer.href,
          :data => data(item_serializer.attributes),
          :links => links(item_serializer.links),
        }.delete_if { |_, value| value.blank? }
      end
    end

    { collection: json }
  end

  private

  def data(attributes)
    attributes.map do |key, value|
      {
        name: key,
        value: value,
      }
    end
  end

  def links(links)
    links.map do |link|
      link[:extra].slice(:name).merge({
        :href => serializer.send(:instance_eval, &link[:block]),
        :rel => link[:rel],
      })
    end
  end
end
