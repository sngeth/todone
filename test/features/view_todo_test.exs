defmodule Todone.ViewTodoTest do
  use Todone.FeatureCase, async: true

  import Wallaby.Query, only: [css: 2]

  test "Visit homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("h2", text: "Welcome to Phoenix"))
  end
end
