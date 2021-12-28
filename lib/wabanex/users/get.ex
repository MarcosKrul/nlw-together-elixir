defmodule Wabanex.Users.Get do

  alias Ecto.UUID
  alias Wabanex.{Repo, User} # mesma coisa q fazer o alias em duas linhas, uma para cada módulo

  def call(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, uuid}) do
    # case, semelhante a switch case
    # outra forma de controlar fluxos e pattern matching
    # não precisa criar outras duas funções (uma para erro e outra para sucesso)
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"} # case a chamada de Repo.get(User, uuid) retorne nil
      user -> {:ok, user}
    end
  end

end
