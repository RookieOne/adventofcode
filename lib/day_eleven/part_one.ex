defmodule Advent.DayEleven.PartOne do
  @moduledoc """
  --- Day 11: Corporate Policy ---

  Santa's previous password expired, and he needs help choosing a new one.

  To help him remember his new password after the old one expires, Santa has devised a method of coming up with a password based on the previous one. Corporate policy dictates that passwords must be exactly eight lowercase letters (for security reasons), so he finds his new password by incrementing his old password string repeatedly until it is valid.

  Incrementing is just like counting with numbers: xx, xy, xz, ya, yb, and so on. Increase the rightmost letter one step; if it was z, it wraps around to a, and repeat with the next letter to the left until one doesn't wrap around.

  Unfortunately for Santa, a new Security-Elf recently started, and he has imposed some additional password requirements:

  Passwords must include one increasing straight of at least three letters, like abc, bcd, cde, and so on, up to xyz. They cannot skip letters; abd doesn't count.
  Passwords may not contain the letters i, o, or l, as these letters can be mistaken for other characters and are therefore confusing.
  Passwords must contain at least two different, non-overlapping pairs of letters, like aa, bb, or zz.
  For example:

  hijklmmn meets the first requirement (because it contains the straight hij) but fails the second requirement requirement (because it contains i and l).
  abbceffg meets the third requirement (because it repeats bb and ff) but fails the first requirement.
  abbcegjk fails the third requirement, because it only has one double letter (bb).
  The next password after abcdefgh is abcdffaa.
  The next password after ghijklmn is ghjaabcc, because you eventually skip all the passwords that start with ghi..., since i is not allowed.  
  """

  @doc """
  ## Examples
    iex> Advent.DayEleven.PartOne.next_password("abcdefgh")
    "abcdffaa"
    iex> Advent.DayEleven.PartOne.next_password("ghijklmn")
    "ghjaabcc"
  """
  def next_password(password) do
    new_password = add_one(password)
    if passes_first_requirement?(new_password)
      && passes_second_requirement?(new_password)
      && passes_third_requirement?(new_password) do
        new_password
    else
      next_password(new_password)
    end
  end

  @doc """
  ## Examples
    
    iex> Advent.DayEleven.PartOne.add_one("a")
    "b"
    iex> Advent.DayEleven.PartOne.add_one("ab")
    "ac"
    iex> Advent.DayEleven.PartOne.add_one("az")
    "ba"
  """
  def add_one(password) do
    # a is 97
    # z is 122
    {_,new_password} = password 
    |> to_char_list
    |> Enum.reverse
    |> Enum.reduce({true, ""}, fn c, {add, new_password} ->
      {carry, char} = case add do
        true ->
          c = (c + 1)
          if c > 122 do
            {true, <<97::utf8>>}
          else
            {false, <<c::utf8>>}
          end
        _ -> 
          {false, <<c::utf8>>}
      end
      {carry, new_password <> char}
    end)
    new_password |> String.reverse
  end

  @doc """
  Passwords must include one increasing straight of at least three letters, like abc, bcd, cde, and so on, up to xyz. They cannot skip letters; abd doesn't count.
  ## Examples
    iex> Advent.DayEleven.PartOne.passes_first_requirement?("abc")
    true
    iex> Advent.DayEleven.PartOne.passes_first_requirement?("abcd")
    true
    iex> Advent.DayEleven.PartOne.passes_first_requirement?("acbd")
    false
    iex> Advent.DayEleven.PartOne.passes_first_requirement?("cbadef")
    true
    iex> Advent.DayEleven.PartOne.passes_first_requirement?("cbadrstuvdolckwj")
    true
    iex> Advent.DayEleven.PartOne.passes_first_requirement?("hijklmmn")
    true
  """
  def passes_first_requirement?(password) do
    password_list = String.graphemes(password)
    _passes_first?(password_list, nil, 0)
  end

  defp _passes_first?(_, _, 3), do: true
  defp _passes_first?([], _, _), do: false
  defp _passes_first?([letter|tail], nil, _) do
    _passes_first?(tail, _unicode_letter(letter), 1)
  end
  defp _passes_first?([letter|tail], last_value, count) do
    current_value = _unicode_letter(letter)
    count = cond do
      last_value + 1 == current_value -> count + 1
      true -> 1
    end
    _passes_first?(tail, current_value, count)
  end

  defp _unicode_letter(letter) do
    <<result::utf8>> = letter
    result
  end

  @doc """
  Passwords may not contain the letters i, o, or l, as these letters can be mistaken for other characters and are therefore confusing.
  ## Examples
    iex> Advent.DayEleven.PartOne.passes_second_requirement?("abc")
    true
    iex> Advent.DayEleven.PartOne.passes_second_requirement?("abci")
    false
    iex> Advent.DayEleven.PartOne.passes_second_requirement?("albc")
    false
    iex> Advent.DayEleven.PartOne.passes_second_requirement?("oabc")
    false
    iex> Advent.DayEleven.PartOne.passes_second_requirement?("abcwebwebegtrhehe")
    true
    iex> Advent.DayEleven.PartOne.passes_second_requirement?("hijklmmn")
    false
  """
  def passes_second_requirement?(password), do: !Regex.match?(~r/(i|o|l)/, password)

  @doc """
  Passwords must contain at least two different, non-overlapping pairs of letters, like aa, bb, or zz.
  ## Examples
    iex> Advent.DayEleven.PartOne.passes_third_requirement?("abc")
    false
    iex> Advent.DayEleven.PartOne.passes_third_requirement?("aabcc")
    true
    iex> Advent.DayEleven.PartOne.passes_third_requirement?("aabaa")
    false
    iex> Advent.DayEleven.PartOne.passes_third_requirement?("abbcegjk")
    false
  """
  def passes_third_requirement?(password) do
    case Regex.scan(~r/(\w)(\1{1})/, password) do
      [] -> false
      results ->
        results |> Enum.map(fn [pair,_,_] -> pair end)
          |> Enum.uniq
          |> Enum.count >= 2
    end
  end

end