defmodule Advent.DayNine.PartOne do
  
  @moduledoc """
  --- Day 9: All in a Single Night ---

  Every year, Santa manages to deliver all of his presents in a single night.

  This year, however, he has some new locations to visit; his elves have provided him the distances between every pair of locations. He can start and end at any two (different) locations he wants, but he must visit each location exactly once. What is the shortest distance he can travel to achieve this?

  For example, given the following distances:

  London to Dublin = 464
  London to Belfast = 518
  Dublin to Belfast = 141
  The possible routes are therefore:

  Dublin -> London -> Belfast = 982
  London -> Dublin -> Belfast = 605
  London -> Belfast -> Dublin = 659
  Dublin -> Belfast -> London = 659
  Belfast -> Dublin -> London = 605
  Belfast -> London -> Dublin = 982
  The shortest of these is London -> Dublin -> Belfast = 605, and so the answer is 605 in this example.
  """

  def find_shortest_route(filename) do
    routes = for line <- File.stream!(filename) do
      captures = Regex.named_captures(~r/(?<from>\w+) to (?<to>\w+) = (?<distance>\d+)/, (line |> String.strip))
      {distance,_} = Integer.parse(captures["distance"])
      {captures["from"],captures["to"],distance}
    end
    destinations = routes |> Enum.map(fn route ->
      {from,to,_} = route
      [from,to]
    end) |> List.flatten |> Enum.uniq
    possible_routes = _possible_routes(destinations)
    distances = _calculate_distances(possible_routes, routes)
    [shortest_route|_] = Enum.sort(distances, fn x,y ->
      {_,d1} = x
      {_,d2} = y
      d1 < d2
    end) |> Enum.take(1)
    {_,shortest_distance} = shortest_route
    shortest_distance
  end

  defp _possible_routes([]), do: [[]]
  defp _possible_routes(destinations) do
    for d <- destinations, n <- _possible_routes(destinations -- [d]), do: [d|n]
  end

  defp _calculate_distances(routes, measured_routes) do
    for route <- routes do
      distance = for i <- 0..length(route)-2 do
        d1 = Enum.at(route, i)
        d2 = Enum.at(route, i+1)
        _find_distance(d1, d2, measured_routes)
      end |> Enum.reduce(0, &(&1 + &2))
      {route, distance}
    end
  end

  defp _find_distance(d1, d2, measured_routes) do
    {_,_,distance} = Enum.find(measured_routes, fn mr ->
      case mr do
        {^d1,^d2,distance} -> true
        {^d2,^d1,distance} -> true
        _ -> false
      end
    end)
    distance
  end

end









