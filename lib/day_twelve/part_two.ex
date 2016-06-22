defmodule Advent.DayTwelve.PartTwo do

  def sum_all_numbers_from_file(filename) do
    for line <- File.stream!(filename) do
      line
    end 
    |> Enum.join 
    |> Poison.decode!
    |> sum_numbers
  end

  @doc """
  ## Examples
    iex> Advent.DayTwelve.PartTwo.sum_numbers([1,2,3])
    6
    iex> Advent.DayTwelve.PartTwo.sum_numbers(%{ "a": 2,"b": 4 })
    6
    iex> Advent.DayTwelve.PartTwo.sum_numbers([[[3]]])
    3
    iex> Advent.DayTwelve.PartTwo.sum_numbers(%{ "a": %{ "b": 4}, "c": -1 })
    3
    iex> Advent.DayTwelve.PartTwo.sum_numbers(%{ "a": [-1,1]})
    0
    iex> Advent.DayTwelve.PartTwo.sum_numbers([-1, %{ "a": 1} ])
    0
    iex> Advent.DayTwelve.PartTwo.sum_numbers(%{})
    0
    iex> Advent.DayTwelve.PartTwo.sum_numbers([])
    0
    iex> Advent.DayTwelve.PartTwo.sum_numbers([1, %{ "c": "red","b": 2 },3])
    4
    iex> Advent.DayTwelve.PartTwo.sum_numbers(%{ "d": "red", "e": [1,2,3,4], "f": 5 })
    0
    iex> Advent.DayTwelve.PartTwo.sum_numbers([1,"red",5])
    6
  """
  def sum_numbers(json) do
    _sum_numbers(json)
  end

  defp _sum_numbers([]), do: 0
  defp _sum_numbers({}), do: 0
  defp _sum_numbers(num) when is_integer(num), do: num
  defp _sum_numbers([h|t]) do
    _sum_numbers(h) + _sum_numbers(t)
  end
  defp _sum_numbers(map) when is_map(map) do
    has_red = Map.values(map) |> Enum.any?(&(&1 == "red"))
    if has_red do
      0
    else
      for {key,value} <- map do
        _sum_numbers(key) + _sum_numbers(value)
      end |> Enum.reduce(0, &(&1+&2))
    end
  end
  defp _sum_numbers(_), do: 0

end