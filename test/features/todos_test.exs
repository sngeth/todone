defmodule Todone.ViewTodoTest do
  use Todone.FeatureCase, async: true
  import Wallaby.Query, only: [css: 2, text_field: 1, button: 1]
  alias Todone.Factory

  test "Creating a todo", %{session: session} do
    session
    |> visit("/todos/new")
    |> assert_has(css("h2", text: "New Todo"))
    |> fill_in(text_field("Description"), with: "Learn Elixir")
    |> click(button("Submit"))
    |> assert_has(css("h2", text: "Show Todo"))
    |> assert_has(css("ul > li", text: "Description: Learn Elixir"))
    |> assert_has(css(".alert-info", text: "Todo created successfully."))
  end

  test "Show a todo", %{session: session} do
    user = Factory.insert!(:user)
    todo = Factory.insert!(:todo, description: "Learn Elixir")

    session
    |> visit("/todos/#{todo.id}")
    |> assert_has(css("h2", text: "Show Todo"))
    |> assert_has(css("ul > li", text: "Description: Learn Elixir"))
  end
end
