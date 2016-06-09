defmodule Advent.DayTwo do
  
  @moduledoc """
    --- Day 2: I Was Told There Would Be No Math ---

    The elves are running low on wrapping paper, and so they need to submit an order for more. They have a list of the dimensions (length l, width w, and height h) of each present, and only want to order exactly as much as they need.

    Fortunately, every present is a box (a perfect right rectangular prism), which makes calculating the required wrapping paper for each gift a little easier: find the surface area of the box, which is 2*l*w + 2*w*h + 2*h*l. The elves also need a little extra paper for each present: the area of the smallest side.

    For example:

    A present with dimensions 2x3x4 requires 2*6 + 2*12 + 2*8 = 52 square feet of wrapping paper plus 6 square feet of slack, for a total of 58 square feet.
    A present with dimensions 1x1x10 requires 2*1 + 2*10 + 2*10 = 42 square feet of wrapping paper plus 1 square foot of slack, for a total of 43 square feet.

    --- Part Two ---

    The elves are also running low on ribbon. Ribbon is all the same width, so they only have to worry about the length they need to order, which they would again like to be exact.

    The ribbon required to wrap a present is the shortest distance around its sides, or the smallest perimeter of any one face. Each present also requires a bow made out of ribbon as well; the feet of ribbon required for the perfect bow is equal to the cubic feet of volume of the present. Don't ask how they tie the bow, though; they'll never tell.

    For example:

    A present with dimensions 2x3x4 requires 2+2+3+3 = 10 feet of ribbon to wrap the present plus 2*3*4 = 24 feet of ribbon for the bow, for a total of 34 feet.
    A present with dimensions 1x1x10 requires 1+1+1+1 = 4 feet of ribbon to wrap the present plus 1*1*10 = 10 feet of ribbon for the bow, for a total of 14 feet.
    
  """

  def read_file(filename) do
    {:ok, input} = File.read(filename) 
    presents = input |> String.split("\n")
    calculate_for_presents(presents)
  end

  def ribbon_for_input(filename) do
    {:ok, input} = File.read(filename) 
    presents = _get_presents_from_input(input)
    calculate_ribbon_for_presents(presents)
  end

  def calculate_ribbon_for_presents([present|presents]) do
    [length, width, height] = present
    calculate_ribbon(length: length, width: width, height: height) + calculate_ribbon_for_presents(presents)
  end
  def calculate_ribbon_for_presents([]), do: 0

  defp _get_presents_from_input(input) do
    input |> String.split("\n") |> _create_presents
  end

  defp _create_presents([present|presents]) do
    data = present |> String.split("x") |> Enum.map(fn num -> 
      {result,_} = Integer.parse(num)
      result
    end)
    [data] ++ _create_presents(presents)
  end
  defp _create_presents([]), do: []

  def calculate_for_presents([present|presents]) do
    [length,width,height] = present |> String.split("x") |> Enum.map(fn num -> 
      {result,_} = Integer.parse(num)
      result
    end)
    calculate_wrapping_paper(length: length, width: width, height: height) + calculate_for_presents(presents)
  end
  def calculate_for_presents([]), do: 0

  @doc """
  Calculates the amount of wrapping paper needed to wrap present with given dimensions

  # Examples
    iex> Advent.DayTwo.calculate_wrapping_paper(length: 2, width: 3, height: 4)
    58
    iex> Advent.DayTwo.calculate_wrapping_paper(length: 1, width: 1, height: 10)
    43
  """
  def calculate_wrapping_paper(length: length, width: width, height: height) do
    # 2*l*w + 2*w*h + 2*h*l
    sides = [length*width, width*height, height*length]
    paper = sides |> Enum.reduce(0, fn(s, sum) -> (2*s) + sum end)
    slack = sides |> Enum.min
    paper + slack
  end
  def calculate_wrapping_paper(_), do: 0

  @doc """
  Calculate the amount of ribbon needed for a present.

  The ribbon required to wrap a present is the shortest distance around its sides, or the smallest perimeter of any one face. Each present also requires a bow made out of ribbon as well; the feet of ribbon required for the perfect bow is equal to the cubic feet of volume of the present. Don't ask how they tie the bow, though; they'll never tell.

  A present with dimensions 2x3x4 requires 2+2+3+3 = 10 feet of ribbon to wrap the present plus 2*3*4 = 24 feet of ribbon for the bow, for a total of 34 feet.
  A present with dimensions 1x1x10 requires 1+1+1+1 = 4 feet of ribbon to wrap the present plus 1*1*10 = 10 feet of ribbon for the bow, for a total of 14 feet.

  # Example
    iex> Advent.DayTwo.calculate_ribbon(length: 2, width: 3, height: 4)
    34
    iex> Advent.DayTwo.calculate_ribbon(length: 1, width: 1, height: 10)
    14
  """
  def calculate_ribbon(length: length, width: width, height: height) do
    # ribbon = smallest perimeter of any one face
    faces = [{height,length}, {width,height}, {width,length}]
    ribbon = faces |> Enum.map(fn {s1,s2} -> _perimeter(s1,s2) end) |> Enum.min
    # bow = cubic feet of volume
    bow = length * width * height
    ribbon + bow
  end
  defp _perimeter(side1, side2), do: side1 * 2 + side2 * 2
end














