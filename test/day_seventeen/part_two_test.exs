defmodule Advent.DaySeventeen.PartTwoTest do
  use ExUnit.Case
  alias Advent.DaySeventeen.PartTwo
  doctest Advent.DaySeventeen.PartTwo

  test "should solve example" do
    result = PartTwo.read_file("lib/day_seventeen/example.txt", 25)

    assert result == 3
  end

  test "should solve problem" do
    result = PartTwo.read_file("lib/day_seventeen/problem.txt", 150)

    assert result == 57
  end

end