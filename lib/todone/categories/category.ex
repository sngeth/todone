defmodule Todone.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todone.Categories.Category
  alias Todone.Todos.Todo


  schema "categories" do
    field :name, :string
    has_many :todos, Todo

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
