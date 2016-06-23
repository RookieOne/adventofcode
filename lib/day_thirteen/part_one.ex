defmodule Advent.DayThirteen.PartOne do
  @moduledoc """
  --- Day 13: Knights of the Dinner Table ---

  In years past, the holiday feast with your family hasn't gone so well. Not everyone gets along! This year, you resolve, will be different. You're going to find the optimal seating arrangement and avoid all those awkward conversations.

  You start by writing up a list of everyone invited and the amount their happiness would increase or decrease if they were to find themselves sitting next to each other person. You have a circular table that will be just big enough to fit everyone comfortably, and so each person will have exactly two neighbors.

  For example, suppose you have only four attendees planned, and you calculate their potential happiness as follows:

  Alice would gain 54 happiness units by sitting next to Bob.
  Alice would lose 79 happiness units by sitting next to Carol.
  Alice would lose 2 happiness units by sitting next to David.
  Bob would gain 83 happiness units by sitting next to Alice.
  Bob would lose 7 happiness units by sitting next to Carol.
  Bob would lose 63 happiness units by sitting next to David.
  Carol would lose 62 happiness units by sitting next to Alice.
  Carol would gain 60 happiness units by sitting next to Bob.
  Carol would gain 55 happiness units by sitting next to David.
  David would gain 46 happiness units by sitting next to Alice.
  David would lose 7 happiness units by sitting next to Bob.
  David would gain 41 happiness units by sitting next to Carol.

  Then, if you seat Alice next to David, Alice would lose 2 happiness units (because David talks so much), but David would gain 46 happiness units (because Alice is such a good listener), for a total change of 44.

  If you continue around the table, you could then seat Bob next to Alice (Bob gains 83, Alice gains 54). Finally, seat Carol, who sits next to Bob (Carol gains 60, Bob loses 7) and David (Carol gains 55, David gains 41). The arrangement looks like this:

       +41 +46
  +55   David    -2
  Carol       Alice
  +60    Bob    +54
       -7  +83
  After trying every other seating arrangement in this hypothetical scenario, you find that this one is the most optimal, with a total change in happiness of 330.
  """
  # i want to read each line in
  # i want to set the happiness ranks per person
  # some algorith for creating seating arrangements
  # i need to be able to score a seating arrangement

  def read_file(filename) do
    result = for line <- File.stream!(filename) do
      line = line |> String.strip
      %{ "happiness" => happiness, "affect" => affect, "name" => name, "other" => other } = Regex.named_captures(~r/(?<name>\w+) would (?<affect>gain|lose) (?<happiness>\d+) happiness units by sitting next to (?<other>\w+)./, line)
      {happiness,_} = Integer.parse(happiness)
      happiness = case affect do
        "gain" -> happiness
        "lose" -> happiness * -1
      end
      %{ "happiness" => happiness, "name" => name, "other" => other }
    end 
    |> Enum.reduce(%{}, &(_set_map(&1, &2)))

    preferences = _sort_preferences(result)

    seating = %{}
    guests = Map.keys(preferences)
    seating_arrangments = permutations_of(guests)
    [{_, happiness}] = seating_arrangments |> Enum.map(fn s ->
      {s, score_seating_arrangement(s, preferences)}
    end)
    |> Enum.sort(fn {_,score1},{_,score2} ->
      score1 > score2
    end)
    |> Enum.take(1)
    happiness
  end

  defp _set_map(%{ "happiness" => happiness, "name" => name, "other" => other }, map) do
    list = Map.get(map, name, [])
    list = [{other,happiness}|list]
    Map.put(map, name, list)
  end

  defp _sort_preferences(preferences) do
    for {name,list} <- preferences, into: %{} do
      sorted_list = Enum.sort(list, fn {_, happiness1}, {_,happiness2} ->
        happiness1 > happiness2
      end)
      {name, sorted_list}
    end
  end

  def score_seating_arrangement(seating_arrangement, preferences) do
    count = Enum.count(seating_arrangement)
    for s <- 0..count-1 do
      name = Enum.at(seating_arrangement, s)
      list = preferences[name]
      other = cond do
        s + 1 >= count -> Enum.at(seating_arrangement, 0)
        true -> Enum.at(seating_arrangement, s + 1)
      end
      happiness1 = get_happiness(name, other, preferences)
      happiness2 = get_happiness(other, name, preferences)
      happiness1 + happiness2
    end |> Enum.reduce(0, &(&1+&2))
  end

  def get_happiness(name, other, preferences) do
    list = preferences[name]
    [result] = list 
    |> Enum.filter(fn {o,happiness} -> o == other end)
    |> Enum.map(fn {_,happiness} -> happiness end)
    |> Enum.take(1)
    result
  end

  def permutations_of([]) do
    [[]]
  end

  def permutations_of(list) do
    for h <- list, t <- permutations_of(list -- [h]), do: [h | t]
  end

end