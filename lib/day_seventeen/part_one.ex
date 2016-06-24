defmodule Advent.DaySeventeen.PartOne do
  
  def read_file(filename, target) do
    containers = File.stream!(filename) |> Stream.map(&make_container/1) |> Enum.to_list
    containers_count = length(containers)

    combos = get_combos(containers_count)
      |> Enum.map(fn c -> normalize_combos(c, containers_count) end)

    combos 
      |> Enum.map(fn combo -> get_combo_value(combo, containers) end)
      |> Enum.filter(fn x -> x == target end)
      |> length
  end

  def make_container(input) do
    input |> String.strip |> Integer.parse |> elem(0)
  end

  def get_combos(n) do
    stop_value = (1..n) |> Enum.map(fn _ -> 1 end) |> Integer.undigits(2)
    _get_combos(0, stop_value, [])
  end
  defp _get_combos(value, stop_value, combos) when value > stop_value, do: combos
  defp _get_combos(value, stop_value, combos) do
    combo = Integer.digits(value, 2)
    combos = [combo|combos]
    _get_combos(value + 1, stop_value, combos)
  end

  def normalize_combos(combo, containers_count) do
    case length(combo) do
      l when l == containers_count -> combo
      l -> _normalize_combos(combo, containers_count - l)
    end
  end
  defp _normalize_combos(combo, 0), do: combo
  defp _normalize_combos(combo, n), do: _normalize_combos([0|combo], n-1)

  def get_combo_value([], [], sum), do: sum
  def get_combo_value([c|combos], [container|containers], sum \\ 0) do
    get_combo_value(combos, containers, sum + c*container)
  end

end