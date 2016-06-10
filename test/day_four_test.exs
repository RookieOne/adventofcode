defmodule Advent.DayFourTests do
  use ExUnit.Case
  doctest Advent.DayFour

  test "Example 1 input should return correct result" do
    key = "abcdef"
    magic_number = Advent.DayFour.find_magic_number(key)
    assert magic_number == 609043
  end
  test "Example 2 input should return correct result" do
    key = "pqrstuv"
    magic_number = Advent.DayFour.find_magic_number(key)
    assert magic_number == 1048970
  end
  test "Puzzle input should return correct result" do
    key = "ckczppom"
    magic_number = Advent.DayFour.find_magic_number(key)
    assert magic_number == 117946
  end

  test "Puzzle input part 2 should return correct result" do
    key = "ckczppom"
    magic_number = Advent.DayFour.find_magic_number_part_2(key)
    assert magic_number == 3938038
  end
end