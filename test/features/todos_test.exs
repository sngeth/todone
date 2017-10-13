defmodule Todone.ViewTodoTest do
  use Todone.FeatureCase, async: true

  import Wallaby.Query, only: [css: 2, text_field: 1, button: 1]

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
end
