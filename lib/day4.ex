# day4.ex
# valid passphrase

defmodule Day4 do
  @moduledoc """
  Day 4, count valid passphrases in input
  Part 1: valid passphrases contain no duplicate words
  Part 2: valid passphrases contain no anagrams
  """

  def day4 do
    phrases = "input/input4.txt"
              |> File.read!
              |> String.split("\n")
    count1 = Enum.count(phrases, &is_valid_passphrase1(&1))
    count2 = Enum.count(phrases, &is_valid_passphrase2(&1))
    IO.puts "Valid passphrases (part 1): #{count1}"
    IO.puts "Valid passphrases (part 1): #{count2}"
  end

  ########
  # Part 1
  def is_valid_passphrase1(""), do: false
  def is_valid_passphrase1(passphrase) do
    passphrase
    |> String.split
    |> contains_duplicates
    |> Kernel.!
  end

  defp contains_duplicates(words) do
    contains_duplicates(words, MapSet.new)
  end

  defp contains_duplicates([], _), do: false
  defp contains_duplicates([word | rest], word_set) do
    if MapSet.member?(word_set, word) do
      true
    else
      contains_duplicates(rest, MapSet.put(word_set, word))
    end
  end

  ########
  # Part 2
  def is_valid_passphrase2(""), do: false
  def is_valid_passphrase2(passphrase) do
    passphrase
    |> String.split
    |> contains_anagrams
    |> Kernel.!
  end

  defp contains_anagrams(words) do
    contains_anagrams(words, MapSet.new)
  end

  defp contains_anagrams([], _), do: false
  defp contains_anagrams([word | rest], word_set) do
    sorted_word = word
                  |> String.graphemes
                  |> Enum.sort
                  |> Enum.join
    if MapSet.member?(word_set, sorted_word) do
      true
    else
      contains_anagrams(rest, MapSet.put(word_set, sorted_word))
    end
  end
end
