defmodule Advent.DayFourteen.PartTwoTest do
  use ExUnit.Case
  alias Advent.DayFourteen.PartTwo
  doctest PartTwo

  test "solve example" do
    most_points = PartTwo.read_file("lib/day_fourteen/example.txt", 1000)

    assert most_points == 689
  end

  test "solve problem" do
    most_points = PartTwo.read_file("lib/day_fourteen/problem.txt", 2503)

    assert most_points == 1102
  end

end