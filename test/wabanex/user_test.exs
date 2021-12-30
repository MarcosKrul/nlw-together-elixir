defmodule Wabanex.UserTest do
  # Wabanex.DataCase
  # modulo util para testes de changesets
  # já importa o ecto para usar o banco
  # configura o ecto e o postgres para trabalhar no modo sandbox (reverte as ações de testes)
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, return a valid changeset" do
      params = %{name: "Nome", email: "email@valido.com", password: "senha123456"}
      assert %Ecto.Changeset{valid?: true, changes: params, errors: []} = User.changeset(params)
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = %{name: "Nome", email: "emailinvalido.com"}

      expected_response = %{email: ["has invalid format"], password: ["can't be blank"]}

      assert errors_on(User.changeset(params)) == expected_response
    end
  end
end
