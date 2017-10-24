defmodule TodoneWeb.TodoControllerTest do
  use TodoneWeb.ConnCase
  use Plug.Test

  alias Todone.Todos
  alias Todone.Users
  alias Todone.Factory

  @create_attrs %{"description" => "some description"}
  @update_attrs %{"description" => "some updated description"}
  @invalid_attrs %{"description" => nil}
  @user_attrs %{"password" => "some crypted_password", "email" => "example@example.com"}

  def fixture(:todo) do
    category = Factory.insert!(:category)

    todo_attrs = Map.put(@create_attrs, "user", user_fixture())
                  |> Map.put("category_id", category.id)

    {:ok, todo} = Todos.create_todo(todo_attrs)
    todo
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@user_attrs)
      |> Users.create_user()

    %{ user | password: nil }
  end

  describe "index" do
    test "lists all todos", %{conn: conn} do
      user = user_fixture()

      conn = init_test_session(conn, current_user: user.id)
             |> get(todo_path(conn, :index))

      assert html_response(conn, 200) =~ "Listing Todos"
    end
  end

  describe "new todo" do
    test "renders form", %{conn: conn} do
      conn = get conn, todo_path(conn, :new)
      assert html_response(conn, 200) =~ "New Todo"
    end
  end

  describe "create todo" do
    test "redirects to show when data is valid", %{conn: conn} do
      user = user_fixture()
      category = Factory.insert!(:category)
      todo_attrs = Map.put(@create_attrs, "category_id", category.id)

      conn = init_test_session(conn, current_user: user.id)
             |> post(todo_path(conn, :create), todo: todo_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == todo_path(conn, :show, id)

      conn = get conn, todo_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Todo"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, todo_path(conn, :create), todo: @invalid_attrs
      assert html_response(conn, 200) =~ "New Todo"
    end
  end

  describe "edit todo" do
    setup [:create_todo]

    test "renders form for editing chosen todo", %{conn: conn, todo: todo} do
      conn = init_test_session(conn, current_user: todo.user.id)
             |> get(todo_path(conn, :edit, todo))

      assert html_response(conn, 200) =~ "Edit Todo"
    end
  end

  describe "update todo" do
    setup [:create_todo]

    test "redirects when data is valid", %{conn: conn, todo: todo} do

      conn = init_test_session(conn, current_user: todo.user.id)
             |> put(todo_path(conn, :update, todo), todo: @update_attrs)

      assert redirected_to(conn) == todo_path(conn, :show, todo)

      conn = get conn, todo_path(conn, :show, todo)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, todo: todo} do
      conn = put conn, todo_path(conn, :update, todo), todo: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Todo"
    end
  end

  describe "delete todo" do
    setup [:create_todo]

    test "deletes chosen todo", %{conn: conn, todo: todo} do

      conn = init_test_session(conn, current_user: todo.user.id)
             |> delete(todo_path(conn, :delete, todo))

      assert redirected_to(conn) == todo_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, todo_path(conn, :show, todo)
      end
    end
  end

  defp create_todo(_) do
    todo = fixture(:todo)
    {:ok, todo: todo}
  end
end
