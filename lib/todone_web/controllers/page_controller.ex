defmodule TodoneWeb.PageController do
  use TodoneWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
