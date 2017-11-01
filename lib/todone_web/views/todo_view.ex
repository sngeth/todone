require IEx

defmodule TodoneWeb.TodoView do
  use TodoneWeb, :view
  alias Todone.Todos

  def category_name(nil) do
    "None"
  end

  def category_name(category) do
    category.name
  end

  def todo_completed?(todo) do
    case Todos.completed_today?(todo) do
      true -> "Completed"
      false -> "Incomplete"
    end
  end
end
