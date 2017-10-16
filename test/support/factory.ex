defmodule Todone.Factory do
  import Ecto.Query
  alias Todone.Repo
  alias Todone.Users.User
  alias Todone.Todos.Todo

  def build(:user) do
    %User{email: "test@test.com"}
  end

  def build(:todo) do
    %Todo{description: "A todo",
      user: find_first_or_build(:user)
    }
  end

  def build(factory_name, attributes) do
    build(factory_name) |> struct(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    Repo.insert! build(factory_name, attributes)
  end

  defp find_first_or_build(:user) do
    Repo.one(from(User, limit: 1)) || build(:user)
  end
end
