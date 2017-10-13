defmodule Todone.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todone.Users.User


  schema "users" do
    field :crypted_password, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :crypted_password])
    |> validate_required([:email, :crypted_password])
    |> unique_constraint(:email)
  end
end
