defmodule Advent.DayEight do

  @moduledoc """
  --- Day 8: Matchsticks ---

  Space on the sleigh is limited this year, and so Santa will be bringing his list as a digital copy. He needs to know how much space it will take up when stored.

  It is common in many programming languages to provide a way to escape special characters in strings. For example, C, JavaScript, Perl, Python, and even PHP handle special characters in very similar ways.

  However, it is important to realize the difference between the number of characters in the code representation of the string literal and the number of characters in the in-memory string itself.
  """

  def count_file(filename) do
    for line <- File.stream!(filename) do
      line |> String.strip |> character_count
    end |> Enum.reduce(%{character_count: 0, memory_count: 0}, fn character_counts, result ->
      result = Map.put(result, :character_count, result[:character_count] + character_counts[:character_count])
      result = Map.put(result, :memory_count, result[:memory_count] + character_counts[:memory_count])
      result
    end)
  end

  @doc """
  Returns a map with the first value being the number of characters of code for string, and the second value being the number of characters in memory for the string
  ## Examples
    iex> Advent.DayEight.character_count("\\"\\"")
    %{character_count: 2, memory_count: 0}
    iex> Advent.DayEight.character_count("\\"a\\"")
    %{character_count: 3, memory_count: 1}
    iex> Advent.DayEight.character_count("\\"abc\\"")
    %{character_count: 5, memory_count: 3}
  """
  def character_count(string) do
    character_count = String.length(string)
    memory_count = string |> String.replace(~r/(\\")|(\\\\)|(\\x..)/, "_") |> String.length
    memory_count = memory_count - 2
    %{character_count: character_count, memory_count: memory_count}
  end


  def count_file_part_2(filename) do
    for line <- File.stream!(filename) do
      line |> String.strip |> encode_count
    end |> Enum.reduce(%{character_count: 0, encoded_count: 0}, fn character_counts, result ->
      result = Map.put(result, :character_count, result[:character_count] + character_counts[:character_count])
      result = Map.put(result, :encoded_count, result[:encoded_count] + character_counts[:encoded_count])
      result
    end)
  end

  def encode_count(string) do
    character_count = String.length(string)
    IO.inspect character_count
    IO.puts string
    encoded_string = string |> _encode
    IO.puts encoded_string
    encoded_count = (encoded_string |> String.length) + 2
    %{character_count: character_count, encoded_count: encoded_count}
  end

  defp _encode(""), do: ""
  defp _encode("\\" <> string) do
    "\\\\" <> _encode(string)
  end
  defp _encode("\"" <> string) do
    "\\\"" <> _encode(string)
  end
  defp _encode(string) do
    IO.inspect "encode #{string}"
    letter = String.slice(string, 0, 1)
    rest = String.slice(string, 1, String.length(string))
    letter <> _encode(rest)
  end

end