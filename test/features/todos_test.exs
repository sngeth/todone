defmodule Todone.ViewTodoTest do
  use Todone.FeatureCase, async: true
  import Wallaby.Query, only: [css: 2, text_field: 1, button: 1, link: 1, option: 1]

  alias Todone.Factory

  test "Creating a todo", %{session: session} do
    Factory.insert!(:user)
    Factory.insert!(:category)

    session
    |> visit("/")
    |> click(link("Log in"))
    |> assert_has(css("h2", test: "Log in"))
    |> fill_in(text_field("Email"), with: "test@test.com")
    |> fill_in(text_field("Password"), with: "password")
    |> click(button("Login"))
    |> click(link("Dashboard"))
    |> click(link("New Todo"))
    |> click(option("Career"))
    |> fill_in(text_field("Description"), with: "Learn Elixir")
    |> click(button("Submit"))
    |> assert_has(css("h2", text: "Show Todo"))
    |> assert_has(css("ul > li", text: "Description: Learn Elixir"))
    |> assert_has(css(".alert-info", text: "Todo created successfully."))
  end

  test "Only list todos created by user", %{session: session} do
    user = Factory.insert!(:user)
    user2 = Factory.insert!(:user, email: "test2@test.com")
    Factory.insert!(:todo, description: "Learn Elixir", user: user)
    Factory.insert!(:todo, description: "Learn Elm", user: user2)

    session
    |> visit("/")
    |> click(link("Log in"))
    |> assert_has(css("h2", test: "Log in"))
    |> fill_in(text_field("Email"), with: "test@test.com")
    |> fill_in(text_field("Password"), with: "password")
    |> click(button("Login"))
    |> click(link("Dashboard"))
    |> assert_has(css("td", text: "Learn Elixir"))
    |> refute_has(css("td", text: "Learn Elm"))
  end
end
