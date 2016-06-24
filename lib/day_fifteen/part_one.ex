defmodule Advent.DayFifteen.PartOne do

  @moduledoc """
  --- Day 15: Science for Hungry People ---

  Today, you set out on the task of perfecting your milk-dunking cookie recipe. All you have to do is find the right balance of ingredients.

  Your recipe leaves room for exactly 100 teaspoons of ingredients. You make a list of the remaining ingredients you could use to finish the recipe (your puzzle input) and their properties per teaspoon:

  capacity (how well it helps the cookie absorb milk)
  durability (how well it keeps the cookie intact when full of milk)
  flavor (how tasty it makes the cookie)
  texture (how it improves the feel of the cookie)
  calories (how many calories it adds to the cookie)
  You can only measure ingredients in whole-teaspoon amounts accurately, and you have to be accurate so you can reproduce your results in the future. The total score of a cookie can be found by adding up each of the properties (negative totals become 0) and then multiplying together everything except calories.

  For instance, suppose you have these two ingredients:

  Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
  Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
  Then, choosing to use 44 teaspoons of butterscotch and 56 teaspoons of cinnamon (because the amounts of each ingredient must add up to 100) would result in a cookie with the following properties:

  A capacity of 44*-1 + 56*2 = 68
  A durability of 44*-2 + 56*3 = 80
  A flavor of 44*6 + 56*-2 = 152
  A texture of 44*3 + 56*-1 = 76
  Multiplying these together (68 * 80 * 152 * 76, ignoring calories for now) results in a total score of 62842880, which happens to be the best score possible given these ingredients. If any properties had produced a negative total, it would have instead become zero, causing the whole score to multiply to zero.
  """

  def read_file(filename) do
    ingredients = File.stream!(filename) 
    |> Stream.map(&read_ingredient/1) |> Enum.to_list

    combos = get_combos(2)
    # IO.inspect ingredients
    # IO.inspect combos
    blank_properties = %{
      capacity: 0,
      durability: 0,
      flavor: 0,
      texture: 0
    }
    score = for combo <- combos do
      properties = get_cookie_properties(combo, ingredients, blank_properties)
      score_properties(properties)
    end |> Enum.max
    score
  end

  def get_combos(2) do
    for a <- 0..100,
        b <- 0..100,
        a + b == 100 do
          [a,b]
        end
  end

  def score_properties(properties) do
    [:capacity, :durability, :texture, :flavor] |> Enum.reduce(0, fn key, score ->
      IO.inspect properties[key]
      score * score_property(properties[key])
    end)
  end
  def score_property(value) when value < 0, do: 0
  def score_property(value), do: value

  @doc """
  ## Examples
    iex> Advent.DayFifteen.PartOne.read_ingredient("Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8")
    %{name: "Butterscotch", capacity: -1, durability: -2, flavor: 6, texture: 3, calories: 8}
    iex> Advent.DayFifteen.PartOne.read_ingredient("Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3")
    %{name: "Cinnamon", capacity: 2, durability: 3, flavor: -2, texture: -1, calories: 3}
  """
  def read_ingredient(input) do
    %{
      "name" => name,
      "capacity" => capacity,
      "durability" => durability,
      "flavor" => flavor,
      "texture" => texture,
      "calories" => calories
    } = Regex.named_captures(~r/(?<name>\w+): capacity (?<capacity>-?\d+), durability (?<durability>-?\d+), flavor (?<flavor>-?\d+), texture (?<texture>-?\d+), calories (?<calories>-?\d+)/, input)
    %{
      name: name,
      capacity: Integer.parse(capacity) |> elem(0),
      durability: Integer.parse(durability) |> elem(0),
      flavor: Integer.parse(flavor) |> elem(0),
      texture: Integer.parse(texture) |> elem(0),
      calories: Integer.parse(calories) |> elem(0)
    }
  end

  @doc """
  ## Examples
  """
  def get_cookie_properties([], [], properties), do: properties
  def get_cookie_properties([mix|mixes], [ingredient|ingredients], properties) do
    properties = %{
      capacity: properties[:capacity] + (ingredient[:capacity] * mix),
      durability: properties[:durability] + (ingredient[:durability] * mix),
      flavor: properties[:flavor] + (ingredient[:flavor] * mix),
      texture: properties[:texture] + (ingredient[:texture] * mix),
    }

    get_cookie_properties(mixes, ingredients, properties)
  end

  # def score_cookie([], [], score), do: score
  # def score_cookie([mix|mixes], [ingredient|ingredients], score \\ 0) do
  #   IO.inspect mix
  #   score = [:capacity, :durability, :flavor, :texture] 
  #     |> Enum.map(&(ingredient[&1] * mix))
  #     |> Enum.map(fn 
  #       value when value < 0 -> 0
  #       value -> value
  #     end)
  #     |> Enum.reduce(0, &*/2)

  #   score_cookie(mixes, ingredients, score)
  # end

  @doc """
  ## Examples
  """
  def score_ingredient(amount, capacity, durability, flavor, texture) do
    {amount*capacity,amount*durability,amount*flavor,amount*texture}
    # amount * (capacity + durability + flavor + texture)
    # }
  end

end