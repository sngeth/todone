defmodule Todone.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todone.Users.User


  schema "users" do
    field :crypted_password, :string
    field :email, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
  end
end
