defmodule Advent.DayFourteen.PartOne do

  @moduledoc """
  --- Day 14: Reindeer Olympics ---

  This year is the Reindeer Olympics! Reindeer can fly at high speeds, but must rest occasionally to recover their energy. Santa would like to know which of his reindeer is fastest, and so he has them race.

  Reindeer can only either be flying (always at their top speed) or resting (not moving at all), and always spend whole seconds in either state.

  For example, suppose you have the following Reindeer:

  Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
  Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
  After one second, Comet has gone 14 km, while Dancer has gone 16 km. After ten seconds, Comet has gone 140 km, while Dancer has gone 160 km. On the eleventh second, Comet begins resting (staying at 140 km), and Dancer continues on for a total distance of 176 km. On the 12th second, both reindeer are resting. They continue to rest until the 138th second, when Comet flies for another ten seconds. On the 174th second, Dancer flies for another 11 seconds.

  In this example, after the 1000th second, both reindeer are resting, and Comet is in the lead at 1120 km (poor Dancer has only gotten 1056 km by that point). So, in this situation, Comet would win (if the race ended at 1000 seconds).

  """

  def read_file(filename, travel_time) do
    reindeers = for input <- File.stream!(filename), do: parse_line(input)
    distances = reindeers |> Enum.map(&(get_reindeer_distance(&1, travel_time)))
    distances |> Enum.max
  end

  @doc """
  ## Examples
    iex> Advent.DayFourteen.PartOne.parse_line("Vixen can fly 18 km/s for 5 seconds, but then must rest for 84 seconds.")
    %{name: "Vixen", speed: 18, duration: 5, rest_duration: 84}
  """
  def parse_line(input) do
    %{ "name" => name, "speed" => speed, "duration" => duration, "rest_duration" => rest_duration } = Regex.named_captures(~r/(?<name>\w+) can fly (?<speed>\d+) km\/s for (?<duration>\d+) seconds, but then must rest for (?<rest_duration>\d+) seconds./, input)
    {speed,_} = Integer.parse(speed)
    {duration,_} = Integer.parse(duration)
    {rest_duration,_} = Integer.parse(rest_duration)
    %{
      name: name,
      speed: speed,
      duration: duration,
      rest_duration: rest_duration
    }
  end

  def get_reindeer_distance(reindeer, travel_time) do
    distance_traveled(reindeer[:speed], reindeer[:duration], reindeer[:rest_duration], travel_time)
  end

  @doc """
  ## Examples
    iex> Advent.DayFourteen.PartOne.distance_traveled(14, 10, 127, 1)
    14
    iex> Advent.DayFourteen.PartOne.distance_traveled(14, 10, 127, 5)
    70
    iex> Advent.DayFourteen.PartOne.distance_traveled(14, 10, 127, 137)
    140
    iex> Advent.DayFourteen.PartOne.distance_traveled(14, 10, 127, 250)
    280
    iex> Advent.DayFourteen.PartOne.distance_traveled(14, 10, 127, 1000)
    1120
    iex> Advent.DayFourteen.PartOne.distance_traveled(16, 11, 162, 1000)
    1056
  """
  def distance_traveled(speed, duration, rest_duration, travel_time) do
    total_duration = duration + rest_duration

    chunk_distance = round(Float.floor(travel_time / total_duration)) * (speed * duration)

    remaining_time = rem(travel_time, total_duration)

    remaining_distance = ([remaining_time, duration] |> Enum.min) * speed

    chunk_distance + remaining_distance
  end

end