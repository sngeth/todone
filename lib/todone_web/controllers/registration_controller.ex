defmodule TodoneWeb.RegistrationController do
  use TodoneWeb, :controller

  alias Todone.Users
  alias Todone.Users.User

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Your account was created")
        |> redirect(to: "/todos")
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Unable to create account")
        |> render("new.html", changeset: changeset)
    end
  end
end
