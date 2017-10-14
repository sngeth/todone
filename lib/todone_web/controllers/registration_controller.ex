defmodule TodoneWeb.RegistrationController do
  use TodoneWeb, :controller

  alias Todone.Users
  alias Todone.Users.User

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    render conn, changeset: changeset
  end
end
