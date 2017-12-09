# day9.ex
# stream of garbage

defmodule Day9 do
  @moduledoc """
  Day 9, stream of garbage
  Part 1: calculate score
  Part 2: count garbage characters
  """
  def day9 do
    input = "input/input9.txt"
            |> File.read!
            |> String.trim
    score = input
            |> calc_score
    garbage = input
            |> count_garbage

    IO.puts("Part 1 score is #{score}")
    IO.puts("Part 2 garbage #{garbage}")
  end

  ########
  # Part 1
  def calc_score(str), do: calc_score(trim_garbage(str), 0, 0)

  def calc_score(<<"{", rest::binary>>, score, level), do: calc_score(rest, score, level + 1)
  def calc_score(<<"}", rest::binary>>, score, level), do: calc_score(rest, score + level, level - 1)
  def calc_score("", score, 0), do: score

  def trim_garbage("<" <> rest) do
    rest
    |> skip_garbage
    |> trim_garbage
  end

  # , wasn't garbage in the description, but I don't need it
  def trim_garbage("," <> rest), do: trim_garbage(rest)
  def trim_garbage(<<c, rest::binary>>), do: <<c>> <> trim_garbage(rest)
  def trim_garbage(""), do: ""

  def skip_garbage(""), do: ""
  def skip_garbage("!!" <> rest), do: skip_garbage(rest)
  def skip_garbage("!>" <> rest), do: skip_garbage(rest)
  def skip_garbage(">" <> rest), do: rest
  def skip_garbage(<<_, rest::binary>>), do: skip_garbage(rest)

  ########
  # Part 2
  def count_garbage("<" <> rest), do: count_garbage(rest, :garbage)
  def count_garbage(<<_, rest::binary>>), do: count_garbage(rest)
  def count_garbage(""), do: 0

  defp count_garbage(<<"!", _, rest::binary>>, :garbage), do: count_garbage(rest, :garbage)
  defp count_garbage(">" <> rest, :garbage), do: count_garbage(rest)
  defp count_garbage(<<_, rest::binary>>, :garbage), do: 1 + count_garbage(rest, :garbage)
end
