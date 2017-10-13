defmodule Todone.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todone.Todos.Todo


  schema "todos" do
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(%Todo{} = todo, attrs) do
    todo
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
