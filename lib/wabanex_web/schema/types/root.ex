# define os entrypoints
# "rotas" de um api

defmodule WabanexWeb.Schema.Types.Root do
  alias WabanexWeb.Schema.Types
  alias WabanexWeb.Resolvers.User, as: UserResolver

  use Absinthe.Schema.Notation

  import_types WabanexWeb.Schema.Types.User
  import_types Types.Custom.UUID4

  object :root_query do
    field :get_user, type: :user do # "get_user" semelhante a definicao de uma rota
      arg :id, non_null(:uuid4)
      resolve &UserResolver.get/2 # mesma coisa que:
      # resolve fn params, contexto -> UserResolver.get(params, context) end
    end
  end

  object :root_mutation do
    field :create_user, type: :user do
      arg :input, non_null(:create_user_input)
      resolve &UserResolver.create/2
    end
  end
end
