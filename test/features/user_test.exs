defmodule Todone.UserTest do
  use Todone.FeatureCase, async: true

  import Wallaby.Query, only: [css: 2, text_field: 1, button: 1, link: 1]

  test "Signing up a new user", %{session: session} do
    session
    |> visit("/")
    |> click(link("Log in"))
    |> assert_has(css("h2", test: "Log in"))
    |> click(link("Sign up"))
    |> assert_has(css("h2", test: "Sign up"))
    |> fill_in(text_field("Email"), with: "test@test.com")
    |> fill_in(text_field("Password"), with: "test123")
    |> click(button("Submit"))
    #|> assert_has(css("h2", text: "Welcome User!"))
  end
end
