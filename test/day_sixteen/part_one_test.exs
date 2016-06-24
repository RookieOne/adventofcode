defmodule Advent.DaySixteen.PartOneTest do
  use ExUnit.Case
  alias Advent.DaySixteen.PartOne

  test "should problem" do
    sue = PartOne.read_file("lib/day_sixteen/problem.txt")

    assert sue == "213"
  end

end