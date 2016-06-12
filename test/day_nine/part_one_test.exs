defmodule Advent.DayNine.PartOneTest do
  use ExUnit.Case

  @tag :day_nine
  @tag :problem
  test "Problem" do
    result = Advent.DayNine.PartOne.find_shortest_route("lib/day_nine/problem.txt")
    assert result == 141
  end

  @tag :day_nine
  @tag :example
  test "Example scenario" do
    result = Advent.DayNine.PartOne.find_shortest_route("lib/day_nine/scenario_one.txt")
    assert result == 605
  end

end