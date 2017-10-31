defmodule Todone.Todos do
  @moduledoc """
  The Todos context.
  """

  import Ecto.Query, warn: false
  alias Todone.Repo

  alias Todone.Todos.Todo
  alias Todone.Completions.Completion

  @doc """
  Returns the list of todos.

  ## Examples

      iex> list_todos()
      [%Todo{}, ...]

  """
  def list_todos do
    Repo.all(Todo) |> Repo.preload([:user, :completions])
  end

  @doc """
  Gets a single todo.

  Raises `Ecto.NoResultsError` if the Todo does not exist.

  ## Examples

      iex> get_todo!(123)
      %Todo{}

      iex> get_todo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_todo!(id) do
    Repo.get!(Todo, id) |> Repo.preload([:user, :completions])
  end

  @doc """
  Creates a todo.

  ## Examples

      iex> create_todo(%{field: value})
      {:ok, %Todo{}}

      iex> create_todo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_todo(attrs \\ %{}) do

    %Todo{}
    |> Todo.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, attrs["user"])
    |> Repo.insert()
  end

  @doc """
  Updates a todo.

  ## Examples

      iex> update_todo(todo, %{field: new_value})
      {:ok, %Todo{}}

      iex> update_todo(todo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_todo(%Todo{} = todo, attrs) do
    todo
    |> Todo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Todo.

  ## Examples

      iex> delete_todo(todo)
      {:ok, %Todo{}}

      iex> delete_todo(todo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_todo(%Todo{} = todo) do
    Repo.delete(todo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo changes.

  ## Examples

      iex> change_todo(todo)
      %Ecto.Changeset{source: %Todo{}}

  """
  def change_todo(%Todo{} = todo) do
    Todo.changeset(todo, %{})
  end

  @doc """
  Completes a Todo.
  """
  def complete_todo(%Todo{} = todo) do
    if !completed_today?(todo), do: Repo.insert(%Completion{todo_id: todo.id})
  end

  def completed_today?(todo) do
    today = Timex.format!(Timex.today, "%F", :strftime)

    todo.completions |> Enum.any?(fn x ->
      "#{x.inserted_at.year}-#{x.inserted_at.month}-#{x.inserted_at.day}" == today
    end)
  end
end
