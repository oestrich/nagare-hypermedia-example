class TodosSerializer < Nagare::Collection
  include Nagare::Hypermedia

  key "hyper:todos"
  attributes :count

  link "curies", array: true, name: "hyper", templated: true do
    "http://example.com/docs/rels/{rel}"
  end

  href do
    context.href
  end

  def count
    collection.count
  end
end
