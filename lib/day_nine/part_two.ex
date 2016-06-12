defmodule Advent.DayNine.PartTwo do
  
  @moduledoc """
  --- Part Two ---

  The next year, just to show off, Santa decides to take the route with the longest distance instead.

  He can still start and end at any two (different) locations he wants, and he still must visit each location exactly once.

  For example, given the distances above, the longest route would be 982 via (for example) Dublin -> London -> Belfast.
  """

  def find_longest_route(filename) do
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
    [longest_route|_] = Enum.sort(distances, fn x,y ->
      {_,d1} = x
      {_,d2} = y
      d1 > d2
    end) |> Enum.take(1)
    {_,longest_distance} = longest_route
    longest_distance
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









