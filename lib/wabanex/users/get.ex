defmodule Wabanex.Users.Get do
  import Ecto.Query

  alias Ecto.UUID
  alias Wabanex.{Repo, User, Training} # mesma coisa q fazer o alias em duas linhas, uma para cada módulo

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
      user -> {:ok, load_training(user)}
    end
  end

  defp load_training(user) do
    today = Date.utc_today()

    # ^ - operador utilizado para fixar o valor da variável
    # não poderá ser reatribuido com pattern matching
    query = from t in Training, where: ^today >= t.start_date and ^today <= t.end_date

    Repo.preload(user, trainings: {first(query, :inserted_at), :exercises})
  end

end
