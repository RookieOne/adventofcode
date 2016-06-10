defmodule Advent.DayFiveTests do
  use ExUnit.Case
  doctest Advent.DayFive

  test "Returns nice string count for test input" do
    nice_string_count = Advent.DayFive.count_nice_strings_in_file("test/day_five_test_input.txt")
    assert nice_string_count == 3
  end
  test "Returns nice string count for problem input" do
    nice_string_count = Advent.DayFive.count_nice_strings_in_file("test/day_five_input.txt")
    assert nice_string_count == 255
  end

  test "Part 2 - Returns nice string count for test input" do
    nice_string_count = Advent.DayFive.count_nice_strings_in_file_v2("test/day_five_test_part_two_input.txt")
    assert nice_string_count == 2
  end
  test "Part 2 - Returns nice string count for problem input" do
    nice_string_count = Advent.DayFive.count_nice_strings_in_file_v2("test/day_five_input.txt")
    assert nice_string_count == 55
  end
end