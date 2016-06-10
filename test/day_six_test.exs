defmodule Advent.DaySixTest do
  use ExUnit.Case
  doctest Advent.DaySix

  test "should return correct light for problem" do
    assert 569999 == Advent.DaySix.count_lights_with_file("problem_inputs/day_six_problem.txt")
  end

  test "should return correct lights for scenario 1 by hand" do
    grid = Advent.DaySix.toggle_lights(%{}, {0,0}, {2,0})
    assert 3 == Advent.DaySix.count_lights(grid)
    
    grid = Advent.DaySix.toggle_lights(grid, {0,0}, {1,2})
    assert 5 == Advent.DaySix.count_lights(grid)

    grid = Advent.DaySix.turn_off_lights(grid, {0,1}, {2,1})
    assert 3 == Advent.DaySix.count_lights(grid)

    grid = Advent.DaySix.turn_on_lights(grid, {1,1}, {2,2})
    assert 6 == Advent.DaySix.count_lights(grid)
  end
  test "should return correct lights for scenario 1 with file" do
    assert 6 == Advent.DaySix.count_lights_with_file("problem_inputs/day_six_scenario1.txt")
  end

  test "should return correct lights for scenario 2 by hand" do
    grid = Advent.DaySix.turn_on_lights(%{}, {0,0}, {5,5})
    assert 36 == Advent.DaySix.count_lights(grid)
    
    grid = Advent.DaySix.turn_off_lights(grid, {0,0}, {2,2})
    assert 27 == Advent.DaySix.count_lights(grid)

    grid = Advent.DaySix.toggle_lights(grid, {0,2}, {5,3})
    assert 21 == Advent.DaySix.count_lights(grid)
  end
  test "should return correct lights for scenario 2 with file" do
    assert 21 == Advent.DaySix.count_lights_with_file("problem_inputs/day_six_scenario2.txt")
  end
end