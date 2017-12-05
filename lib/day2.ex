# day2.ex
# spreadsheet checksum

defmodule Day2 do
  @moduledoc """
  Day 2, calculate checksum for spreadsheet

  Part 1:
  Calculate the difference between the largest and smallest value in each row.
  Checksum is the sum for all rows

  Part 2:
  Each row has exactly one pair that's evenly divisible, calculate the dividend.
  Checksum is the sum for all rows
  """

  def day2 do
    input = String.trim_trailing(File.read! "input/input2.txt")
    output1 = calc_checksum1(input)
    output2 = calc_checksum2(input)
    IO.puts "Checksum part 1: #{output1}"
    IO.puts "Checksum part 2: #{output2}"
  end

  ########
  # Part 1
  def calc_checksum1(str) do
    str
    |> String.split("\n")
    |> Enum.map(&calc_line_range(&1))
    |> Enum.sum
  end

  # "5 1 9 5\n" -> 8
  # max is 9, min is 1, range is 9 - 1 = 8
  def calc_line_range(""), do: 0
  def calc_line_range(line), do: calc_line_range(String.trim_leading(line), nil, 0)

  defp calc_line_range("", minimum, maximum), do: maximum - minimum

  defp calc_line_range(line, minimum, maximum) do
    {num, line} = Integer.parse(line)
    maximum = max(maximum, num)
    minimum = min(minimum, num)
    calc_line_range(String.trim_leading(line), minimum, maximum)
  end

  ########
  # Part 2
  def calc_checksum2(str) do
    str
    |> String.split("\n")
    |> Enum.map(&parse_line(&1))
    |> Enum.map(&find_div_pair(&1))
    |> Enum.sum
  end

  # [5, 9, 2, 8] -> {8, 2} -> 4
  # find the pairs that are even divisible and divide them
  # apparently there are no 0's in the input
  def find_div_pair([]), do: 0
  def find_div_pair(nums) do
    # The instructions imply there will be only one divisible pair per line
    # We assert this through pattern matching
    [dividend] = for x <- nums, y <- nums, x != y, rem(x, y) == 0, do: div(x, y)
    dividend
  end

  # "5 1 9 5\n" -> [5, 1, 9, 5]
  def parse_line(line) do
    line
    |> String.split
    |> Enum.map(&String.to_integer(&1))
  end
end
