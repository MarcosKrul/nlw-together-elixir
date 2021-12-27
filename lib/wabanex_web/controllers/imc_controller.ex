defmodule WabanexWeb.IMCController do
  use WabanexWeb, :controller

  # cria um apelido para a ultima parte do modulo
  alias Wabanex.IMC

  def index(conn, params) do
    params
    |> IMC.calculate()
    |> handle_response(conn)
  end

  defp handle_response({:ok, result}, conn), do:
    render_response(conn, :ok, {true, "Operação realizada com sucesso.", result})

  defp handle_response({:error, result}, conn), do:
    render_response(conn, :bad_request, {false, "Não foi possível realizar a operação.", result})

  defp render_response(conn, status, {success, message, data}) do
    conn
    |> put_status(status)
    |> json(%{:message => message, :success => success, :data => data})
  end

end
