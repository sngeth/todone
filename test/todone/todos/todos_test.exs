require IEx

defmodule Todone.TodosTest do
  use Todone.DataCase

  alias Todone.Todos
  alias Todone.Users
  alias Todone.Factory

  describe "todos" do
    alias Todone.Todos.Todo

    @valid_attrs %{"description" => "some description"}
    @update_attrs %{"description" => "some updated description"}
    @invalid_attrs %{"description" => nil}
    @user_attrs %{"password" => "some crypted_password", "email" => "example@example.com"}

    def todo_fixture(attrs \\ %{}) do
      category = Factory.insert!(:category)

      {:ok, todo} =
        attrs
        |> Map.put("user", user_fixture())
        |> Map.put("category_id", category.id)
        |> Enum.into(@valid_attrs)
        |> Todos.create_todo()

      todo
    end

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@user_attrs)
        |> Users.create_user()

      %{ user | password: nil }
    end

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert Todos.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Todos.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      user = user_fixture()
      todo_attrs = Map.put(@valid_attrs, "user", user)

      assert {:ok, %Todo{} = todo} = Todos.create_todo(todo_attrs)
      assert todo.description == "some description"
      assert todo.user_id == user.id
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      assert {:ok, todo} = Todos.update_todo(todo, @update_attrs)
      assert %Todo{} = todo
      assert todo.description == "some updated description"
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_todo(todo, @invalid_attrs)
      assert todo == Todos.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = Todos.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Todos.change_todo(todo)
    end

    test "complete_todo/1 completes a todo" do
      todo = todo_fixture()
      Todos.complete_todo(todo)

      todo = Todos.get_todo!(todo.id) |> Todone.Repo.preload(:completions)

      assert length(todo.completions) == 1
    end
  end
end
