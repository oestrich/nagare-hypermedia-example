class TodosController < ApplicationController
  def index
    render json: Todo.all, context: { href: todos_url }, serializers: {
      collection: TodosSerializer,
      item: TodoSerializer,
    }
  end

  def show
    todo = Todo.find(params[:id])
    render json: todo, context: { self: todo_url(todo) }, serializers: {
      collection: TodosSerializer,
      item: TodoSerializer,
    }
  end
end
