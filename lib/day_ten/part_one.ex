defmodule Advent.DayTen.PartOne do

  @moduledoc """
  --- Day 10: Elves Look, Elves Say ---

  Today, the Elves are playing a game called look-and-say. They take turns making sequences by reading aloud the previous sequence and using that reading as the next sequence. For example, 211 is read as "one two, two ones", which becomes 1221 (1 2, 2 1s).

  Look-and-say sequences are generated iteratively, using the previous value as input for the next step. For each step, take the previous value, and replace each run of digits (like 111) with the number of digits (3) followed by the digit itself (1).

  For example:

  1 becomes 11 (1 copy of digit 1).
  11 becomes 21 (2 copies of digit 1).
  21 becomes 1211 (one 2 followed by one 1).
  1211 becomes 111221 (one 1, one 2, and two 1s).
  111221 becomes 312211 (three 1s, two 2s, and one 1).
  """

  def process(number: number, process_times: process_times) do
    (1..process_times) |> Enum.reduce(number, fn _,number ->
      look_and_say(number)
    end) |> String.length
  end

  @doc """
  
  ## Examples
    iex> Advent.DayTen.PartOne.look_and_say("1")
    "11"
    iex> Advent.DayTen.PartOne.look_and_say("11")
    "21"
    iex> Advent.DayTen.PartOne.look_and_say("21")
    "1211"
    iex> Advent.DayTen.PartOne.look_and_say("1211")
    "111221"
    iex> Advent.DayTen.PartOne.look_and_say("111221")
    "312211"
  """
  def look_and_say(number) do
    number_array = String.graphemes(number)
    _get_number_counts(number_array, nil, 0, [])
  end

  defp _get_number_counts(number_array, number, number_count, number_counts) do
    {number, count, number_counts} = Enum.reduce(number_array, {nil, 0, ""}, fn n, {number, count, number_counts} -> 
      cond do
        number == nil -> {n, 1, number_counts}
        number != n -> {n, 1, number_counts <> "#{count}#{number}"}
        true -> {n, count+1, number_counts}
      end
    end)
    number_counts <> "#{count}#{number}"
  end

end