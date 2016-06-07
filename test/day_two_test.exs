defmodule Advent.DayTwoTests do
  use ExUnit.Case
  doctest Advent.DayTwo

  test "return amount of wrapping paper needed for test data" do
    result = Advent.DayTwo.read_file("./test/day_two_test_data.txt")
    assert result == 58 + 43
  end
  test "return amount of wrapping paper needed" do
    result = Advent.DayTwo.read_file("./test/day_two_input.txt")
    assert result == 1586300
  end
  test "return amount of ribbon needed for test data" do
    result = Advent.DayTwo.ribbon_for_input("./test/day_two_test_data.txt")
    assert result == 34 + 14
  end
  test "return amount of ribbon needed" do
    result = Advent.DayTwo.ribbon_for_input("./test/day_two_input.txt")
    assert result == 3737498
  end
end