defmodule Rocketpay.Numbers do

  def sum_from_file(filename) do
    "#{filename}.csv"
      |> File.read()
      |> handle_file()
    # o mesmo que
    #  file = File.read("#{filename}.csv")
    #  handle_file(file)

  end

  defp handle_file({:ok, result}) do
    numbers_string_list = String.split(result, ",")

    numbers_int_list = Enum.map(numbers_string_list,
      fn number -> String.to_integer(number) end
    )

    numbers_sum_list = Enum.sum(numbers_int_list)

    {:ok, %{ result: numbers_sum_list }}
  end

  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid file!"}}
end
