defmodule Todone.Completions.Completion do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todone.Completions.Completion
  alias Todone.Todos.Todo


  schema "completions" do
    belongs_to :todo, Todo

    timestamps()
  end
end
