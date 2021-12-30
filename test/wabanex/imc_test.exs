defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  # um para cada funcao publica q se deseja testar
  describe "calculate/1" do
    test "when the file exists, return the data" do
      expected_response =
        {:ok,
         %{
           "Nome1" => 27.469135802469133,
           "Nome2" => 30.859374999999993,
           "Nome3" => 23.668639053254438,
           "Nome4" => 28.088991030674453
         }
        }

      assert expected_response == IMC.calculate(%{"filename" => "students.csv"})
    end

    test "when the wrong filename is given, return an error" do
      expected_response = {:error, "Error opening file"}
      assert expected_response == IMC.calculate(%{"filename" => "students1.csv"})
    end
  end
end
