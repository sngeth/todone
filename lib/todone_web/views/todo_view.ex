defmodule TodoneWeb.TodoView do
  use TodoneWeb, :view
  alias Todone.Todos.Todo

  def category_name(nil) do
    "None"
  end

  def category_name(category) do
    category.name
  end
end
