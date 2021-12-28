defmodule Wabanex.Users.Create do

  alias Wabanex.{Repo, User} # mesma coisa q fazer o alias em duas linhas, uma para cada módulo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end

end
