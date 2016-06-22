defmodule Advent.DayTen.PartOneTest do
  use ExUnit.Case
  doctest Advent.DayTen.PartOne

  test "should return length of result for example scenario" do
    result = Advent.DayTen.PartOne.process(number: "1", process_times: 5)

    assert result == 6
  end
  test "should return length of result for problem" do
    result = Advent.DayTen.PartOne.process(number: "1113222113", process_times: 40)

    assert result == 252594
  end

end