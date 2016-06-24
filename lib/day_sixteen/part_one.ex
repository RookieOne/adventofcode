defmodule Advent.DaySixteen.PartOne do

  @moduledoc """
  --- Day 16: Aunt Sue ---

  Your Aunt Sue has given you a wonderful gift, and you'd like to send her a thank you card. However, there's a small problem: she signed it "From, Aunt Sue".

  You have 500 Aunts named "Sue".

  So, to avoid sending the card to the wrong person, you need to figure out which Aunt Sue (which you conveniently number 1 to 500, for sanity) gave you the gift. You open the present and, as luck would have it, good ol' Aunt Sue got you a My First Crime Scene Analysis Machine! Just what you wanted. Or needed, as the case may be.

  The My First Crime Scene Analysis Machine (MFCSAM for short) can detect a few specific compounds in a given sample, as well as how many distinct kinds of those compounds there are. According to the instructions, these are what the MFCSAM can detect:

  children, by human DNA age analysis.
  cats. It doesn't differentiate individual breeds.
  Several seemingly random breeds of dog: samoyeds, pomeranians, akitas, and vizslas.
  goldfish. No other kinds of fish.
  trees, all in one group.
  cars, presumably by exhaust or gasoline or something.
  perfumes, which is handy, since many of your Aunts Sue wear a few kinds.
  In fact, many of your Aunts Sue have many of these. You put the wrapping from the gift into the MFCSAM. It beeps inquisitively at you a few times and then prints out a message on ticker tape:

  children: 3
  cats: 7
  samoyeds: 2
  pomeranians: 3
  akitas: 0
  vizslas: 0
  goldfish: 5
  trees: 3
  cars: 2
  perfumes: 1
  You make a list of the things you can remember about each Aunt Sue. Things missing from your list aren't zero - you simply don't remember the value.
  """

  def read_file(filename) do
    aunts = File.stream!(filename) |> Stream.map(&create_aunt/1) |> Enum.to_list
    facts = %{
      "children" => "3",
      "cats" => "7",
      "samoyeds" => "2",
      "pomeranians" => "3",
      "akitas" => "0",
      "vizslas" => "0",
      "goldfish" => "5",
      "trees" => "3",
      "cars" => "2",
      "perfumes" => "1",
    }

    find_match(aunts, facts)
  end

  def find_match([], _), do: nil
  def find_match([aunt|aunts], facts) do
    {aunt_number, aunt_facts} = aunt
    match = for {key,value} <- aunt_facts do
      case facts[key] do
        nil -> false
        fact_value when fact_value == value -> true
        _ -> false
      end
    end |> Enum.all?
    if match, do: aunt_number, else: find_match(aunts, facts)
  end

  @doc """
  Sue 1: children: 1, cars: 8, vizslas: 7
  """
  def create_aunt(input) do
    %{ "number" => number } = Regex.named_captures(~r/Sue (?<number>\d+)/, input)
    things = input
    |> String.replace("Sue #{number}: ", "")
    |> String.strip
    |> String.split(",")
    |> Enum.map(fn thing_string ->
      thing_string |> String.split(":") |> Enum.map(&String.strip/1)
    end)
    things = for thing <- things, into: %{} do
      [name|t] = thing
      number = hd(t)
      {name,number}
    end
    {number, things}
  end

end