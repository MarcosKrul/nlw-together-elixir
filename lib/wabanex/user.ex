defmodule Wabanex.User do
  use Ecto.Schema
  import Ecto.Changeset #conjunto de funcoes; utils para validacao de dados
  # todas as manipulações no banco (inserção, atualizacação, ...) são feitas com changesets
  # abrir documentacao pelo terminal
  #   h Ecto.Changeset

  # variavel de modulo, só existe aqui
  # parecido com: fields = [:name, :password, :name]
  @fields [:email, :password, :name]

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email,     :string
    field :name,      :string
    field :password,  :string
    has_one :training, Wabanex.Training
    timestamps()
  end

  # insercao no banco
  # para testar:
  #  data = %{name: "nome", email: "email", password: "password"}
  #  data |> Wabanex.User.changeset() |> Wabanex.Repo.insert()
  def changeset(params) do
    %__MODULE__{} # nome do modulo atual, mesma coisa que:  %Wabanex.User{}
    |> cast(params, @fields) # tenta converter os dados recebidos para os tipos dos campos
    |> validate_required(@fields) # email, name e password são obrigatórios
    |> validate_length(:password, min: 8) # tamanho mínimo da password
    |> validate_length(:name, min: 2) # tamanho mínimo do name
    |> validate_format(:email, ~r/@/) # valida formato do email; regex simples: valores entre um @
    |> unique_constraint([:email])
  end

end
