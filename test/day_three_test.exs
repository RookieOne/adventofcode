defmodule Advent.DayThreeTests do
  use ExUnit.Case
  doctest Advent.DayThree

  test "example 1" do
    directions = ">"
    result = Advent.DayThree.calculate_number_of_houses_that_receive_presents(directions)
    assert result == 2
  end
  test "houses that receive presents from input" do
    {:ok, directions} = File.read("./test/day_three_input.txt")
    result = Advent.DayThree.calculate_number_of_houses_that_receive_presents(directions)
    assert result == 2565
  end

  test "part two - houses that receive presents from my scenario" do
    directions = "^vv^"
    result = Advent.DayThree.calculate_number_of_houses_that_receive_presents(:with_robo_santa, directions)
    assert result == 3
  end
  test "part two - houses that receive presents from my scenario 2" do
    directions = "^v^vv^"
    result = Advent.DayThree.calculate_number_of_houses_that_receive_presents(:with_robo_santa, directions)
    assert result == 5
  end
  test "part two - houses that receive presents from input" do
    {:ok, directions} = File.read("./test/day_three_input.txt")
    result = Advent.DayThree.calculate_number_of_houses_that_receive_presents(:with_robo_santa, directions)
    assert result == 2639
  end
end