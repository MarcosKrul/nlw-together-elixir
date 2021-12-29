# padrao do absinthe
# as funcoes recebem dois parametros
# primeiro parametro: argumentos
# segundo parametro: contexto (role, token de autenticacao, ...)

defmodule WabanexWeb.Resolvers.User do
  alias Wabanex.Users   # pega o nome do ultimo modulo como alias
  # alias Wabanex.Users, as: QualquerNome

  def get(%{id: user_id}, _context), do: Users.Get.call(user_id)
  def create(%{input: params}, _context), do: Users.Create.call(params)
end
