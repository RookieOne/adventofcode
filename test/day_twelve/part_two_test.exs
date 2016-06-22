defmodule Advent.DayTwelve.PartTwoTest do
  use ExUnit.Case
  alias Advent.DayTwelve.PartTwo
  doctest PartTwo

  test "return sum of all numbers in problem input" do
    sum = PartTwo.sum_all_numbers_from_file("lib/day_twelve/problem.txt")

    assert sum == 96852
  end

end