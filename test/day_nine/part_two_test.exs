defmodule Advent.DayNine.PartTwoTest do
  use ExUnit.Case

  @tag :day_nine
  @tag :problem
  test "Problem" do
    result = Advent.DayNine.PartTwo.find_longest_route("lib/day_nine/problem.txt")
    assert result == 736
  end

  @tag :day_nine
  @tag :example
  test "Example scenario" do
    result = Advent.DayNine.PartTwo.find_longest_route("lib/day_nine/scenario_one.txt")
    assert result == 982
  end

end