defmodule Advent.DayThirteen.PartOneTest do
  use ExUnit.Case
  alias Advent.DayThirteen.PartOne

  test "should return happiness for example" do
    happiness = Advent.DayThirteen.PartOne.read_file("lib/day_thirteen/example.txt")

    assert happiness == 330
  end

  test "should return happiness for problem" do
    happiness = Advent.DayThirteen.PartOne.read_file("lib/day_thirteen/problem.txt")

    assert happiness == 664
  end

end