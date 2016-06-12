defmodule Advent.DayEightTest do
  use ExUnit.Case
  doctest Advent.DayEight

  @tag :problem
  test "Part 1 - Problem" do
    result = Advent.DayEight.count_file("problem_inputs/day_eight_problem.txt")
    assert result[:character_count] == 6195
    assert result[:memory_count] == 4845
    assert result[:character_count] - result[:memory_count] == 1350
  end

  @tag :part1
  @tag :scenario1
  test "Part 1 - Scenario 1" do
    result = Advent.DayEight.count_file("problem_inputs/day_eight_scenario1.txt")
    assert result[:character_count] == 23
    assert result[:memory_count] == 11
    assert result[:character_count] - result[:memory_count] == 12
  end

  @tag :part2
  @tag :scenario1
  test "Part 2 - Scenario 1" do
    result = Advent.DayEight.count_file_part_2("problem_inputs/day_eight_scenario1.txt")
    assert result[:encoded_count] == 42
    assert result[:character_count] == 23
    assert result[:encoded_count] - result[:character_count] == 19
  end

  @tag :part2
  @tag :example1
  test "Part 2 - Example 1" do
    result = Advent.DayEight.count_file_part_2("problem_inputs/day_eight_example1.txt")
    assert result[:encoded_count] == 6
    assert result[:character_count] == 2
    assert result[:encoded_count] - result[:character_count] == 4
  end

  @tag :part2
  @tag :example2
  test "Part 2 - Example 2" do
    result = Advent.DayEight.count_file_part_2("problem_inputs/day_eight_example2.txt")
    assert result[:encoded_count] == 9
    assert result[:character_count] == 5
    assert result[:encoded_count] - result[:character_count] == 4
  end

  @tag :part2
  @tag :example3
  test "Part 2 - Example 3" do
    result = Advent.DayEight.count_file_part_2("problem_inputs/day_eight_example3.txt")
    assert result[:encoded_count] == 16
    assert result[:character_count] == 10
    assert result[:encoded_count] - result[:character_count] == 6
  end

  @tag :part2
  @tag :example4
  test "Part 2 - Example 4" do
    result = Advent.DayEight.count_file_part_2("problem_inputs/day_eight_example4.txt")
    assert result[:encoded_count] == 11
    assert result[:character_count] == 6
    assert result[:encoded_count] - result[:character_count] == 5
  end

  @tag :part2
  @tag :problem
  test "Part 2 - Problem" do
    result = Advent.DayEight.count_file_part_2("problem_inputs/day_eight_problem.txt")
    assert result[:character_count] == 6195
    assert result[:encoded_count] == 8280
    assert result[:encoded_count] - result[:character_count] == 2085
  end

  @tag :scenario2
  test "Part 1 - Scenario 2" do
    result = Advent.DayEight.count_file("problem_inputs/day_eight_scenario2.txt")
    assert result[:character_count] == 4
    assert result[:memory_count] == 1
    assert result[:character_count] - result[:memory_count] == 3
  end

end