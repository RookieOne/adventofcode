
defmodule Advent.DayOne do
  @moduledoc """
    --- Day 1: Not Quite Lisp ---

    Santa was hoping for a white Christmas, but his weather machine's "snow" function is powered by stars, and he's fresh out! To save Christmas, he needs you to collect fifty stars by December 25th.

    Collect stars by helping Santa solve puzzles. Two puzzles will be made available on each day in the advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

    Here's an easy puzzle to warm you up.
    
    -- Part One --
    Santa is trying to deliver presents in a large apartment building, but he can't find the right floor - the directions he got are a little confusing. He starts on the ground floor (floor 0) and then follows the instructions one character at a time.

    An opening parenthesis, (, means he should go up one floor, and a closing parenthesis, ), means he should go down one floor.

    The apartment building is very tall, and the basement is very deep; he will never find the top or bottom floors.

    For example:

    (()) and ()() both result in floor 0.
    ((( and (()(()( both result in floor 3.
    ))((((( also results in floor 3.
    ()) and ))( both result in floor -1 (the first basement level).
    ))) and )())()) both result in floor -3.
    To what floor do the instructions take Santa?

    -- Part Two --
    Now, given the same instructions, find the position of the first character that causes him to enter the basement (floor -1). The first character in the instructions has position 1, the second character has position 2, and so on.

    For example:

    ) causes him to enter the basement at character position 1.
    ()()) causes him to enter the basement at character position 5.
    What is the position of the character that causes Santa to first enter the basement?
  """

  @doc """
  Returns the floor Santa ends up on

  ## Examples
    iex> Advent.DayOne.find_floor("(())")
    0
    iex> Advent.DayOne.find_floor("()()")
    0
    iex> Advent.DayOne.find_floor("(((")
    3
    iex> Advent.DayOne.find_floor("(()(()(")
    3
    iex> Advent.DayOne.find_floor("))(((((")
    3
    iex> Advent.DayOne.find_floor("())")
    -1
    iex> Advent.DayOne.find_floor("))(")
    -1
    iex> Advent.DayOne.find_floor(")))")
    -3
    iex> Advent.DayOne.find_floor(")())())")
    -3
  """
  def find_floor(input) do
    input |> String.split("") |> _process
  end

  defp _process(["("|chars]), do: 1 + _process(chars)
  defp _process([")"|chars]), do: -1 + _process(chars)
  defp _process(_), do: 0

  @doc """
  Returns the position when Santa first enters the basement.
  Starts at position 1.

  ## Examples
    iex> Advent.DayOne.when_does_santa_enter_the_basement(")")
    {:ok, 1}
    iex> Advent.DayOne.when_does_santa_enter_the_basement("()())")
    {:ok, 5}
    iex> Advent.DayOne.when_does_santa_enter_the_basement("(")
    {:error, "never entered the basement"}
  """
  def when_does_santa_enter_the_basement(input) do
    input |> String.split("") |> _basement_position
  end

  defp _basement_position(chars), do: _basement_position(chars, position: 0, floor: 0)
  defp _basement_position(_, position: position, floor: -1), do: {:ok, position}
  defp _basement_position(["("|chars], position: position, floor: floor), do: _basement_position(chars, position: position+1, floor: floor+1)
  defp _basement_position([")"|chars], position: position, floor: floor), do: _basement_position(chars, position: position+1, floor: floor-1)
  defp _basement_position(_, _), do: {:error, "never entered the basement"}

end