defmodule Todone.ViewTodoTest do
  use Todone.FeatureCase, async: true
  import Wallaby.Query, only: [css: 2, text_field: 1, button: 1, link: 1]
  alias Todone.Factory

  test "Creating a todo", %{session: session} do
    Factory.insert!(:user)

    session
    |> visit("/")
    |> click(link("Log in"))
    |> assert_has(css("h2", test: "Log in"))
    |> fill_in(text_field("Email"), with: "test@test.com")
    |> fill_in(text_field("Password"), with: "password")
    |> click(button("Login"))
    |> click(link("Dashboard"))
    |> click(link("New Todo"))
    |> fill_in(text_field("Description"), with: "Learn Elixir")
    |> click(button("Submit"))
    |> assert_has(css("h2", text: "Show Todo"))
    |> assert_has(css("ul > li", text: "Description: Learn Elixir"))
    |> assert_has(css(".alert-info", text: "Todo created successfully."))
  end

  test "List with existing todo", %{session: session} do
    Factory.insert!(:user)
    Factory.insert!(:todo, description: "Learn Elixir")

    session
    |> visit("/")
    |> click(link("Log in"))
    |> assert_has(css("h2", test: "Log in"))
    |> fill_in(text_field("Email"), with: "test@test.com")
    |> fill_in(text_field("Password"), with: "password")
    |> click(button("Login"))
    |> click(link("Dashboard"))
    |> refute_has(css("h2", text: "New Todo"))
  end

  test "Show a todo", %{session: session} do
    Factory.insert!(:user)
    todo = Factory.insert!(:todo, description: "Learn Elixir")

    session
    |> visit("/todos/#{todo.id}")
    |> assert_has(css("h2", text: "Show Todo"))
    |> assert_has(css("ul > li", text: "Description: Learn Elixir"))
  end
end
