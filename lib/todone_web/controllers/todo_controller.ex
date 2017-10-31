defmodule TodoneWeb.TodoController do
  use TodoneWeb, :controller

  plug :load_categories when action in [:new, :create, :edit, :update]

  alias Todone.Todos
  alias Todone.Todos.Todo
  alias Todone.Categories

  def index(conn, _params) do
    todos = Todone.Repo.all(my_todos(current_user(conn)))
            |> Todone.Repo.preload(:category)

    render(conn, "index.html", todos: todos)
  end

  def new(conn, _params) do
    changeset = Todos.change_todo(%Todo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo" => todo_params}) do
    todo_params = Map.put(todo_params, "user", current_user(conn))

    case Todos.create_todo(todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo created successfully.")
        |> redirect(to: todo_path(conn, :show, todo))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Todone.Repo.get!(my_todos(current_user(conn)), id)
            |> Todone.Repo.preload(:category)

    render(conn, "show.html", todo: todo)
  end

  def edit(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)
    changeset = Todos.change_todo(todo)
    render(conn, "edit.html", todo: todo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Todos.get_todo!(id)

    case Todos.update_todo(todo, todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo updated successfully.")
        |> redirect(to: todo_path(conn, :show, todo))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", todo: todo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)
    {:ok, _todo} = Todos.delete_todo(todo)

    conn
    |> put_flash(:info, "Todo deleted successfully.")
    |> redirect(to: todo_path(conn, :index))
  end

  def complete(conn, %{"todo_id" => id}) do
    todo = Todos.get_todo!(id) |> Todone.Repo.preload(:completions)
    Todos.complete_todo(todo)

    conn
    |> put_flash(:info, "Todo completed for today!")
    |> redirect(to: todo_path(conn, :index))
  end

  defp load_categories(conn, _) do
    assign(conn, :categories, Categories.select_categories)
  end

  defp my_todos(user) do
    Ecto.assoc(user, :todos)
  end
end
