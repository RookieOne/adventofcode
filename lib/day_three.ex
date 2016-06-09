defmodule Advent.DayThree do
  @moduledoc """
  --- Day 3: Perfectly Spherical Houses in a Vacuum ---

  Santa is delivering presents to an infinite two-dimensional grid of houses.

  He begins by delivering a present to the house at his starting location, and then an elf at the North Pole calls him via radio and tells him where to move next. Moves are always exactly one house to the north (^), south (v), east (>), or west (<). After each move, he delivers another present to the house at his new location.

  However, the elf back at the north pole has had a little too much eggnog, and so his directions are a little off, and Santa ends up visiting some houses more than once. How many houses receive at least one present?

  For example:

  > delivers presents to 2 houses: one at the starting location, and one to the east.
  ^>v< delivers presents to 4 houses in a square, including twice to the house at his starting/ending location.
  ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.

  --- Part Two ---

  The next year, to speed up the process, Santa creates a robot version of himself, Robo-Santa, to deliver presents with him.

  Santa and Robo-Santa start at the same location (delivering two presents to the same starting house), then take turns moving based on instructions from the elf, who is eggnoggedly reading from the same script as the previous year.

  This year, how many houses receive at least one present?

  For example:

  ^v delivers presents to 3 houses, because Santa goes north, and then Robo-Santa goes south.
  ^>v< now delivers presents to 3 houses, and Santa and Robo-Santa end up back where they started.
  ^v^v^v^v^v now delivers presents to 11 houses, with Santa going one direction and Robo-Santa going the other.

  """

  @doc """
  Calculate the number of houses that receive at least one present

  ## Examples
    iex> Advent.DayThree.calculate_number_of_houses_that_receive_presents(">")
    2
    iex> Advent.DayThree.calculate_number_of_houses_that_receive_presents("^>v<")
    4
    iex> Advent.DayThree.calculate_number_of_houses_that_receive_presents("^v^v^v^v^v")
    2
  """
  def calculate_number_of_houses_that_receive_presents(directions) do
    position = {0,0}
    history = _deliver_present(position, %{})
    history = directions |> String.split("") |> _handle_movement(position, history)
    history |> Map.keys |> Enum.count
  end

  defp _handle_movement([""], _, history), do: history
  defp _handle_movement([direction|directions], position, history) do
    position = _change_position(direction, position)
    history = _deliver_present(position, history)
    _handle_movement(directions, position, history)
  end

  defp _change_position("^", {x,y}), do: {x,y+1}
  defp _change_position("v", {x,y}), do: {x,y-1}
  defp _change_position("<", {x,y}), do: {x-1,y}
  defp _change_position(">", {x,y}), do: {x+1,y}

  defp _deliver_present(position, history) do
    {_,result} = Map.get_and_update(history, position, fn v -> _up_present_count(v) end)
    result
  end

  defp _up_present_count(nil), do: {nil,1}
  defp _up_present_count(current), do: {current,current+1}

  @doc """
    Santa and Robo Santa deliver presents

  ## Examples
    iex> Advent.DayThree.calculate_number_of_houses_that_receive_presents(:with_robo_santa, "^v")
    3
    iex> Advent.DayThree.calculate_number_of_houses_that_receive_presents(:with_robo_santa, "^>v<")
    3
    iex> Advent.DayThree.calculate_number_of_houses_that_receive_presents(:with_robo_santa, "^v^v^v^v^v")
    11
  """
  def calculate_number_of_houses_that_receive_presents(:with_robo_santa, directions) do
    santa_position = {0,0}
    robo_position = {0,0}
    history = _deliver_present(santa_position, %{})
    history = directions |> String.split("") |> _handle_movement_with_robo(:santa, santa_position, robo_position, history)
    history |> Map.keys |> Enum.count
  end

  defp _handle_movement_with_robo([""], _, _, _, history), do: history
  defp _handle_movement_with_robo([direction|directions], turn, santa_position, robo_position, history) do
    case turn do
      :santa ->
        position = _change_position(direction, santa_position)
        history = _deliver_present(position, history)
        _handle_movement_with_robo(directions, :robo, position, robo_position, history)
      :robo ->
        position = _change_position(direction, robo_position)
        history = _deliver_present(position, history)
        _handle_movement_with_robo(directions, :santa, santa_position, position, history)
    end
  end
end










