defmodule Advent.DayFive do
  @moduledoc """
    --- Day 5: Doesn't He Have Intern-Elves For This? ---

    Santa needs help figuring out which strings in his text file are naughty or nice.

    A nice string is one with all of the following properties:

    It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
    It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
    It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
    For example:

    ugknbfddgicrmopn is nice because it has at least three vowels (u...i...o...), a double letter (...dd...), and none of the disallowed substrings.
    aaa is nice because it has at least three vowels and a double letter, even though the letters used by different rules overlap.
    jchzalrnumimnmhp is naughty because it has no double letter.
    haegwjzuvuyypxyu is naughty because it contains the string xy.
    dvszwmarrgswjxmb is naughty because it contains only one vowel.
    How many strings are nice?

    --- Part Two ---

    Realizing the error of his ways, Santa has switched to a better model of determining whether a string is naughty or nice. None of the old rules apply, as they are all clearly ridiculous.

    Now, a nice string is one with all of the following properties:

    It contains a pair of any two letters that appears at least twice in the string without overlapping, like xyxy (xy) or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).
    It contains at least one letter which repeats with exactly one letter between them, like xyx, abcdefeghi (efe), or even aaa.
    For example:

    qjhvhtzxzqqjkmpb is nice because is has a pair that appears twice (qj) and a letter that repeats with exactly one letter between them (zxz).
    xxyxx is nice because it has a pair that appears twice and a letter that repeats with one between, even though the letters used by each rule overlap.
    uurcxstgmygtbstg is naughty because it has a pair (tg) but no repeat with a single letter between them.
    ieodomkazucvgmuy is naughty because it has a repeating letter with one between (odo), but no pair that appears twice.
  """

  def count_nice_strings_in_file(filename) do
    {:ok, input} = File.read(filename) 
    input 
    |> String.split("\n")
    |> Enum.filter(fn s -> nice_string?(s) end)
    |> Enum.count
  end

  @doc """
  Returns true if string is nice and false if string is naughty
  nice strings contain a vowel and have a double letter
  naughty strings contain the combo ab, cd, pq, xy
  ## Examples
    iex> Advent.DayFive.nice_string?("ugknbfddgicrmopn")
    true
    iex> Advent.DayFive.nice_string?("aaa")
    true
    iex> Advent.DayFive.nice_string?("jchzalrnumimnmhp")
    false
    iex> Advent.DayFive.nice_string?("haegwjzuvuyypxyu")
    false
    iex> Advent.DayFive.nice_string?("dvszwmarrgswjxmb")
    false
  """
  def nice_string?(string) do
    has_three_vowels?(string) && has_double_letter(string) && not_naught_combos(string)
  end

  @doc """
  Returns true if string has a vowel (ie aeiou)
  ## Examples
    iex> Advent.DayFive.has_three_vowels?("baa")
    false
    iex> Advent.DayFive.has_three_vowels?("aaa")
    true
    iex> Advent.DayFive.has_three_vowels?("eee")
    true
    iex> Advent.DayFive.has_three_vowels?("iii")
    true
    iex> Advent.DayFive.has_three_vowels?("ooo")
    true
    iex> Advent.DayFive.has_three_vowels?("uuu")
    true
    iex> Advent.DayFive.has_three_vowels?("caiot")
    true
    iex> Advent.DayFive.has_three_vowels?("wwwewduddda")
    true
    iex> Advent.DayFive.has_three_vowels?("wwwwedddda")
    false
    iex> Advent.DayFive.has_three_vowels?("ugknbfddgicrmopn")
    true
  """
  def has_three_vowels?(string) do
    vowel_count = String.split(string, "") |> Enum.reduce(0, fn letter, sum ->
      case letter do
        "a" -> sum + 1
        "e" -> sum + 1
        "i" -> sum + 1
        "o" -> sum + 1
        "u" -> sum + 1
        _ -> sum
      end
    end) 
    vowel_count >= 3
  end

  @doc """
  Returns true if the string has at least one double letter
  ## Examples
    iex> Advent.DayFive.has_double_letter("aa")
    true
    iex> Advent.DayFive.has_double_letter("abc")
    false
    iex> Advent.DayFive.has_double_letter("abcc")
    true
    iex> Advent.DayFive.has_double_letter("xx")
    true
    iex> Advent.DayFive.has_double_letter("abcdde")
    true
    iex> Advent.DayFive.has_double_letter("aabbccdd")
    true
    iex> Advent.DayFive.has_double_letter("xwxwxwxwxwx")
    false
  """
  def has_double_letter(string) do
    String.split(string, "") |> _matches_previous_letter("")
  end

  defp _matches_previous_letter([""|_], _), do: false
  defp _matches_previous_letter([current_letter|letters], previous_letter) do
    if (previous_letter == current_letter), do: true, else: _matches_previous_letter(letters, current_letter)
  end

  @doc """
  Returns true if the string does not contain the strings ab, cd, pq, or xy
  ## Examples
    iex> Advent.DayFive.not_naught_combos("ab")
    false
    iex> Advent.DayFive.not_naught_combos("aa")
    true
    iex> Advent.DayFive.not_naught_combos("cd")
    false
    iex> Advent.DayFive.not_naught_combos("pq")
    false
    iex> Advent.DayFive.not_naught_combos("xy")
    false
    iex> Advent.DayFive.not_naught_combos("cat")
    true
  """
  def not_naught_combos(string) do
    naughty_combos = ["ab", "cd", "pq", "xy"]
    naughty_combos |> Enum.map(&(String.contains?(string,&1))) |> Enum.any? |> Kernel.not
  end

  @doc """
  Returns true if string contains two letters that appear at least twice in string without overlapping and it contains at least one letter which repeats with eactly one letter between them
  ## Examples
    iex> Advent.DayFive.nice_string_v2?("qjhvhtzxzqqjkmpb")
    true
    iex> Advent.DayFive.nice_string_v2?("xxyxx")
    true
    iex> Advent.DayFive.nice_string_v2?("uurcxstgmygtbstg")
    false
    iex> Advent.DayFive.nice_string_v2?("ieodomkazucvgmuy")
    false
  """
  def nice_string_v2?(string) do
    letter_combo?(string) && oreo_letters?(string)
  end

  @doc """
  Returns true if string contains two letters that appear at least twice in string without overlapping
  # Examples
    iex> Advent.DayFive.letter_combo?("xyxy")
    true
    iex> Advent.DayFive.letter_combo?("aabcdefgaa")
    true
    iex> Advent.DayFive.letter_combo?("aaa")
    false
    iex> Advent.DayFive.letter_combo?("abc")
    false
  """
  def letter_combo?(string) do
    length = String.length(string)
    combos = for i <- 1..length-1, do: "#{String.at(string, i-1)}#{String.at(string, i)}"
    combos_count = Enum.count(combos)
    matches = for i <- 0..combos_count do
      combo = Enum.at(combos, i)
      combos |> Enum.slice(i+2, combos_count) |> Enum.any?(&(&1==combo))
    end |> Enum.any?
    matches
  end

  @doc """
  Returns true if string contains at least one letter which repeats with exactly one letter between them
  ## Examples
    iex> Advent.DayFive.oreo_letters?("xyx")
    true
    iex> Advent.DayFive.oreo_letters?("abcdefeghi")
    true
    iex> Advent.DayFive.oreo_letters?("aaa")
    true
    iex> Advent.DayFive.oreo_letters?("aaa")
    true
  """
  def oreo_letters?(string) do
    (for i <- 0..String.length(string)-2, do: String.at(string, i) == String.at(string, i+2)) |> Enum.any?
  end

  def count_nice_strings_in_file_v2(filename) do
    {:ok, input} = File.read(filename) 
    input 
    |> String.split("\n")
    |> Enum.filter(&(nice_string_v2? &1))
    |> Enum.count
  end

end