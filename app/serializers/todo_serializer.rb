class TodoSerializer < Nagare::Item
  include Nagare::Hypermedia

  attributes :title, :completed

  href do
    routes_bridge.todo_url(object)
  end
end
