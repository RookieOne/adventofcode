defmodule Advent.DaySix do
  @moduledoc """
  --- Day 6: Probably a Fire Hazard ---

  Because your neighbors keep defeating you in the holiday house decorating contest year after year, you've decided to deploy one million lights in a 1000x1000 grid.

  Furthermore, because you've been especially nice this year, Santa has mailed you instructions on how to display the ideal lighting configuration.

  Lights in your grid are numbered from 0 to 999 in each direction; the lights at each corner are at 0,0, 0,999, 999,999, and 999,0. The instructions include whether to turn on, turn off, or toggle various inclusive ranges given as coordinate pairs. Each coordinate pair represents opposite corners of a rectangle, inclusive; a coordinate pair like 0,0 through 2,2 therefore refers to 9 lights in a 3x3 square. The lights all start turned off.

  To defeat your neighbors this year, all you have to do is set up your lights by doing the instructions Santa sent you in order.

  For example:

  turn on 0,0 through 999,999 would turn on (or leave on) every light.
  toggle 0,0 through 999,0 would toggle the first line of 1000 lights, turning off the ones that were on, and turning on the ones that were off.
  turn off 499,499 through 500,500 would turn off (or leave off) the middle four lights.

  input looks like: turn on 489,959 through 759,964
  """

  def count_lights_with_file(filename) do
    File.stream!(filename)
    |> Stream.map(&(_to_commands(&1)))
    |> Enum.reduce(%{}, fn instruction, grid ->
      case instruction do
        {:toggle, [start_point, end_point]} -> toggle_lights(grid, start_point, end_point)
        {:turn_on, [start_point, end_point]} -> turn_on_lights(grid, start_point, end_point)
        {:turn_off, [start_point, end_point]} -> turn_off_lights(grid, start_point, end_point)
      end
    end)
    |> count_lights
    # {:ok, input} = File.read(filename)
    # input 
    # |> String.split("\n")
    # |> Enum.map(&(_to_commands(&1)))
    # |> Enum.reduce(%{}, fn instruction, grid ->
    #   case instruction do
    #     {:toggle, [start_point, end_point]} -> toggle_lights(grid, start_point, end_point)
    #     {:turn_on, [start_point, end_point]} -> turn_on_lights(grid, start_point, end_point)
    #     {:turn_off, [start_point, end_point]} -> turn_off_lights(grid, start_point, end_point)
    #   end
    # end)
    # |> count_lights
  end
  defp _to_commands("toggle " <> string), do: {:toggle, _points(string)}
  defp _to_commands("turn on " <> string), do: {:turn_on, _points(string)}
  defp _to_commands("turn off " <> string), do: {:turn_off, _points(string)}

  defp _to_commands(_), do: nil
  defp _points(string) do
    string 
    |> String.split(" through ")
    |> Enum.map(&(String.split(&1, ",")))
    |> Enum.map(fn [x,y] ->
      {x,_} = Integer.parse(x)
      {y,_} = Integer.parse(y)
      {x,y}
    end)
  end

  @doc """
  Returns number of lights lit in grid
  ## Examples
    iex> Advent.DaySix.count_lights(%{{0, 0} => true, {0, 1} => true, {0, 2} => true})
    3
    iex> Advent.DaySix.count_lights(%{{0, 0} => false, {0, 1} => true, {0, 2} => true})
    2
    iex> Advent.DaySix.count_lights(%{{0, 0} => true})
    1
  """
  def count_lights(grid) do
    grid |> Map.values |> Enum.count(&(&1))
  end

  @doc """
  Create grid given row and column count
  """
  def create_grid(row, column) do
    (0..row-1) |> Stream.map(fn _ -> (0..column-1) |> Stream.map(fn _ -> 0 end) |> Enum.to_list end) |> Enum.to_list
  end

  @doc """
  Turn on lights
  ## Examples
    iex> Advent.DaySix.turn_on_lights(%{}, {0,0}, {1,1})
    %{{0, 0} => true, {0, 1} => true, {1, 0} => true, {1, 1} => true}
    iex> Advent.DaySix.turn_on_lights(%{}, {0,0}, {2,2})
    %{{0, 0} => true, {0, 1} => true, {0, 2} => true, {1, 0} => true, {1, 1} => true, {1, 2} => true, {2, 0} => true, {2, 1} => true, {2, 2} => true}
    iex> Advent.DaySix.turn_on_lights(%{ {2,3} => true, {0,1} => false }, {0,0}, {1,1})
    %{{0, 0} => true, {0, 1} => true, {1, 0} => true, {1, 1} => true, {2, 3} => true}
  """
  def turn_on_lights(grid, {startx,starty}, {endx,endy}) do
    for x <- startx..endx, y <- starty..endy, into: grid, do: { {x,y} , true}
  end

  @doc """
  Turn off lights
  ## Examples
    iex> Advent.DaySix.turn_off_lights(%{}, {0,0}, {1,1})
    %{{0, 0} => false, {0, 1} => false, {1, 0} => false, {1, 1} => false}
    iex> Advent.DaySix.turn_off_lights(%{}, {0,0}, {2,2})
    %{{0, 0} => false, {0, 1} => false, {0, 2} => false, {1, 0} => false, {1, 1} => false, {1, 2} => false, {2, 0} => false, {2, 1} => false, {2, 2} => false}
    iex> Advent.DaySix.turn_off_lights(%{ {2,3} => true, {0,1} => true }, {0,0}, {1,1})
    %{{0, 0} => false, {0, 1} => false, {1, 0} => false, {1, 1} => false, {2, 3} => true}
  """
  def turn_off_lights(grid, {startx,starty}, {endx,endy}) do
    for x <- startx..endx, y <- starty..endy, into: grid, do: { {x,y} , false}
  end

  @doc """
  Toggles lights
  ## Examples
    iex> Advent.DaySix.toggle_lights(%{}, {0,0}, {1,1})
    %{{0, 0} => true, {0, 1} => true, {1, 0} => true, {1, 1} => true}
    iex> Advent.DaySix.toggle_lights(%{ {0,0} => true, {0,1} => false }, {0,0}, {1,1})
    %{{0, 0} => false, {0, 1} => true, {1, 0} => true, {1, 1} => true}
  """
  def toggle_lights(grid, {startx,starty}, {endx,endy}) do
    for x <- startx..endx, y <- starty..endy, into: grid, do: { {x,y} , _toggle(grid[{x,y}])}
  end
  defp _toggle(nil), do: true
  defp _toggle(value), do: !value

end