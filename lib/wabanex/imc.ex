# pattern matching elixir

# {:ok, msg} = {:ok, "teste"}
# o operador da esquerda dá "match" com o da direita
# ambos são uma tupla com :ok e algum conteudo
# para que essa expressão seja verdadeira, "msg" deve ser igual a "teste"
# +- como atribuição/desestruturação

# abrir o terminal interativo do elixir dentro do projeto
#   iex -S mix
# tentar abrir um arquivo q não existe
#   File.read("naoexiste")
#   {:error, :enoent}
# portanto, para pegar o erro basta usar pattern matching da seguinte forma
# {:error, variavel} = File.read("naoexiste")
# "variavel" passa a possuir o valor com a mensagem do erro
# tentar abrir um arquivo q existe
#   File.read("students.csv")
#   {:ok, "nome;email;senha"}
# portanto, para pegar o conteudo do arquivo basta usar pattern matching da seguinte forma
# {:ok, conteudo} = File.read("students.csv")

defmodule Wabanex.IMC do
  def calculate(%{"filename" => filename}) do
    # result ira receber
    # ou {:error, reason}
    # ou {:ok, content}
    filename
    |> File.read()
    |> handle_file()
    # handle_file está "sobrecarregada"
    # será aplicado pattern matching para escolher qual das duas funções será executada
    # pattern matching com o parâmetro
    # as tentativas são feitas de cima para baixo
    # se nenhum função der "match", será lançada uma exceção
  end

  defp handle_file({:ok, content}) do
    data =
      content
      |> String.split("\n")
      |> Enum.map(fn item -> parse_line(item) end)
      |> Enum.into(%{})

    {:ok, data}
  end

  defp handle_file({:error, _reason}) do
    {:error, "Error opening file"}
  end

  defp handle_file(_) do
    # essa função é o último caso, quando nehuma outra a cima deu match no parâmetro
  end

  defp parse_line(item) do
    item
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)  # mesma coisa que: |> List.update_at(1, fn i -> String.to_float(i) end)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
  end

  defp calculate_imc([name, height, weight]), do: { name, weight / (height * height) }
end
