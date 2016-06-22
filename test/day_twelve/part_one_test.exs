defmodule Advent.DayTwelve.PartOneTest do
  use ExUnit.Case
  alias Advent.DayTwelve.PartOne
  doctest PartOne

  test "return sum of all numbers in problem input" do
    sum = PartOne.sum_all_numbers_from_file("lib/day_twelve/problem.txt")

    assert sum == 156366
  end

end