defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, return imc", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      expected_response = %{
        "data" => %{
          "Nome1" => 27.469135802469133,
          "Nome2" => 30.859374999999993,
          "Nome3" => 23.668639053254438,
          "Nome4" => 28.088991030674453
        },
        "message" => "Operação realizada com sucesso.",
        "success" => true
      }

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params)) # método http da rota; imc_path => executar "mix phx.routes"
        |> json_response(:ok)

      assert expected_response == response
    end

    test "when the file doesnt exists", %{conn: conn} do
      params = %{"filename" => "students1.csv"}

      expected_response = %{
        "data" => "Error opening file",
        "message" => "Não foi possível realizar a operação.",
        "success" => false
      }

      response =
        conn
        # método http da rota; imc_path() => executar "mix phx.routes"
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      assert expected_response == response
    end
  end
end
