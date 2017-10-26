defmodule Todone.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todone.Todos.Todo
  alias Todone.Users.User
  alias Todone.Categories.Category
  alias Todone.Completions.Completion

  schema "todos" do
    field :description, :string
    belongs_to :user, User
    belongs_to :category, Category
    has_many :completions, Completion

    timestamps()
  end

  @doc false
  def changeset(%Todo{} = todo, attrs) do
    todo
    |> cast(attrs, [:description, :category_id])
    |> validate_required([:description])
  end
end
