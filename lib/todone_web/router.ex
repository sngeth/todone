defmodule TodoneWeb.Router do
  use TodoneWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoneWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/log_in", PageController, :log_in
    get "/sign_up", PageController, :sign_up
    resources "/todos", TodoController
    resources "/registrations", RegistrationController, only: [:new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoneWeb do
  #   pipe_through :api
  # end
end
