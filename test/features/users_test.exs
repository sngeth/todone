require IEx

defmodule Todone.UserTest do
  use Todone.FeatureCase, async: true
  alias Todone.Factory

  import Wallaby.Query, only: [css: 2, text_field: 1, button: 1, link: 1]

  test "Signing up a new user", %{session: session} do
    session
    |> visit("/")
    |> click(link("Register"))
    |> assert_has(css("h2", test: "Sign up"))
    |> fill_in(text_field("Email"), with: "test@test.com")
    |> fill_in(text_field("Password"), with: "test123")
    |> click(button("Submit"))
    |> assert_has(css(".alert-info", text: "Your account was created"))
  end

  test "Signing up an invalid new user", %{session: session} do
    session
    |> visit("/")
    |> click(link("Register"))
    |> assert_has(css("h2", test: "Sign up"))
    |> fill_in(text_field("Email"), with: "")
    |> fill_in(text_field("Password"), with: "")
    |> click(button("Submit"))
    |> assert_has(css(".alert-danger", text: "Unable to create account"))
    |> assert_has(css("span", text: "can't be blank", count: 2))
  end

  test "Logging in", %{session: session} do
    Factory.insert!(:user, email: "test@test.com")

    session
    |> visit("/")
    |> click(link("Log in"))
    |> assert_has(css("h2", test: "Log in"))
    |> fill_in(text_field("Email"), with: "test@test.com")
    |> fill_in(text_field("Password"), with: "password")
    |> click(button("Login"))
    |> assert_has(css(".alert-info", text: "Logged in"))
  end

  test "Logging in with wrong password", %{session: session} do
    Factory.insert!(:user, email: "test@test.com")

    session
    |> visit("/")
    |> click(link("Log in"))
    |> assert_has(css("h2", test: "Log in"))
    |> fill_in(text_field("Email"), with: "test@test.com")
    |> fill_in(text_field("Password"), with: "wrongpassword")
    |> click(button("Login"))
    |> assert_has(css(".alert-info", text: "Wrong email or password"))
  end
end
