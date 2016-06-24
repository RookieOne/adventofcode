defmodule Advent.DaySeventeen.PartOneTest do
  use ExUnit.Case
  alias Advent.DaySeventeen.PartOne
  doctest Advent.DaySeventeen.PartOne

  test "should solve example" do
    result = PartOne.read_file("lib/day_seventeen/example.txt", 25)

    assert result == 4
  end

  test "should solve problem" do
    result = PartOne.read_file("lib/day_seventeen/problem.txt", 150)

    assert result == 654
  end

end