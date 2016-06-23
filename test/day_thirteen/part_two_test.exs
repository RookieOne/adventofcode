defmodule Advent.DayThirteen.PartTwoTest do
  use ExUnit.Case
  alias Advent.DayThirteen.PartTwo

  test "should return happiness for example" do
    happiness = Advent.DayThirteen.PartTwo.read_file("lib/day_thirteen/example.txt")

    assert happiness == 286
  end

  test "should return happiness for problem" do
    happiness = Advent.DayThirteen.PartTwo.read_file("lib/day_thirteen/problem.txt")

    assert happiness == 640
  end

end