defmodule Advent.DayFifteen.PartOneTest do
  use ExUnit.Case
  alias Advent.DayFifteen.PartOne
  doctest PartOne

  test "should solve example" do
    result = PartOne.read_file("lib/day_fifteen/example.txt")

    assert result == 62842880
  end
end