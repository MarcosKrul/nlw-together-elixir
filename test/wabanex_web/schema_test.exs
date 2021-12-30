defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "user:query" do
    test "when a valid id is given, return the user", %{conn: conn} do
      params = %{name: "Nome", email: "email@valido.com", password: "senha123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      graphql = """
        query {
          getUser(id: "#{user_id}") {
            name
            email
          }
        }
      """

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "email@valido.com",
            "name" => "Nome"
          }
        }
      }

      response =
        conn
        |> post("/api/graphql", %{query: graphql})
        |> json_response(:ok)

      assert expected_response == response
    end
  end

  describe "user:mutation" do
    test "when all params are valid, creates the user", %{conn: conn} do
      graphql = """
        mutation {
          createUser(input: {
            name: "Nome",
            email: "email@email.com",
            password: "passwd1234"
          }) {
            name
            email
          }
        }
      """

      expected_response = %{
        "data" => %{"createUser" => %{"email" => "email@email.com", "name" => "Nome"}}
      }

      response =
        conn
        |> post("/api/graphql", %{query: graphql})
        |> json_response(:ok)

      assert response == expected_response
    end
  end
end
