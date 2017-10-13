defmodule TodoneWeb.PageController do
  use TodoneWeb, :controller

  alias Todone.Users
  alias Todone.Users.User

  def index(conn, _params) do
    render conn, "index.html"
  end

  def log_in(conn, _params) do
    render conn, "log_in.html"
  end

  def sign_up(conn, _params) do
    changeset = Users.change_user(%User{})
    render conn, "sign_up.html", changeset: changeset
  end
end
