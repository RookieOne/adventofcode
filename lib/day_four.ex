defmodule Advent.DayFour do
  @moduledoc """
    Santa needs help mining some AdventCoins (very similar to bitcoins) to use as gifts for all the economically forward-thinking little girls and boys.

    To do this, he needs to find MD5 hashes which, in hexadecimal, start with at least five zeroes. The input to the MD5 hash is some secret key (your puzzle input, given below) followed by a number in decimal. To mine AdventCoins, you must find Santa the lowest positive number (no leading zeroes: 1, 2, 3, ...) that produces such a hash.

    For example:

    If your secret key is abcdef, the answer is 609043, because the MD5 hash of abcdef609043 starts with five zeroes (000001dbbfa...), and it is the lowest such number to do so.
    If your secret key is pqrstuv, the lowest number it combines with to make an MD5 hash starting with five zeroes is 1048970; that is, the MD5 hash of pqrstuv1048970 looks like 000006136ef....

    --- Part Two ---

    Now find one that starts with six zeroes.
  """

  @doc """
  Returns magic number for given secret key
  ## Example
    iex> Advent.DayFour.find_magic_number("abcdef")
    609043
    iex> Advent.DayFour.find_magic_number("pqrstuv")
    1048970
  """
  def find_magic_number(key) do
    [{ number, _ }|_] = Stream.iterate(1, fn n -> n+1 end) 
    |> Stream.map(fn number -> { number, _get_hash(key, number) } end)
    |> Stream.filter(fn { number, hash } -> _matches_advent_pattern(hash) end)
    |> Enum.take(1)
    number
  end

  defp _get_hash(key, number), do: :crypto.hash(:md5, "#{key}#{number}") |> Base.encode16()

  defp _matches_advent_pattern("00000" <> hash), do: true
  defp _matches_advent_pattern(_), do: false

  def find_magic_number_part_2(key) do
    [{ number, _ }|_] = Stream.iterate(1, fn n -> n+1 end) 
    |> Stream.map(fn number -> { number, _get_hash(key, number) } end)
    |> Stream.filter(fn { number, hash } -> _matches_advent_pattern_part_2(hash) end)
    |> Enum.take(1)
    number
  end

  defp _matches_advent_pattern_part_2("000000" <> hash), do: true
  defp _matches_advent_pattern_part_2(_), do: false
end