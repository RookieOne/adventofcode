defmodule Advent.DaySixteen.PartTwoTest do
  use ExUnit.Case
  alias Advent.DaySixteen.PartTwo

  test "should problem" do
    sue = PartTwo.read_file("lib/day_sixteen/problem.txt")

    assert sue == "323"
  end

end