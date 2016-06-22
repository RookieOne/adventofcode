defmodule Advent.DayEleven.PartOneTest do
  use ExUnit.Case
  doctest Advent.DayEleven.PartOne

  test "should return new password for problem input part 1" do
    new_password = Advent.DayEleven.PartOne.next_password("hxbxwxba")

    assert new_password == "hxbxxyzz"
  end

  test "should return new password for problem input part 2" do
    new_password = Advent.DayEleven.PartOne.next_password("hxbxxyzz")

    assert new_password == "hxcaabcc"
  end

end