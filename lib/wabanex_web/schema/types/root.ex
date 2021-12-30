# define os entrypoints
# "rotas" de um api

defmodule WabanexWeb.Schema.Types.Root do
  alias WabanexWeb.Schema.Types
  alias WabanexWeb.Resolvers.User, as: UserResolver
  alias WabanexWeb.Resolvers.Training, as: TrainingResolver
  alias Crudry.Middlewares.TranslateErrors

  use Absinthe.Schema.Notation

  import_types Types.User
  import_types Types.Training
  import_types Types.Custom.UUID4

  object :root_query do
    field :get_user, type: :user do # "get_user" semelhante a definicao de uma rota
      arg :id, non_null(:uuid4)
      resolve &UserResolver.get/2 # mesma coisa que:
      # resolve fn params, contexto -> UserResolver.get(params, context) end
      middleware TranslateErrors
    end
  end

  object :root_mutation do
    field :create_user, type: :user do
      arg :input, non_null(:create_user_input)
      resolve &UserResolver.create/2
      middleware TranslateErrors
    end

    field :create_training, type: :training do
      arg :input, non_null(:create_training_input)
      resolve &TrainingResolver.create/2
      middleware TranslateErrors
    end
  end
end
