defmodule Advent.DayFourteen.PartOneTest do
  use ExUnit.Case
  alias Advent.DayFourteen.PartOne
  doctest PartOne

  test "solve problem" do
    max_distance = PartOne.read_file("lib/day_fourteen/problem.txt", 2503)

    assert max_distance == 2640
  end

end