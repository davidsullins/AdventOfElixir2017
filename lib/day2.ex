# day2.ex
# spreadsheet checksum

defmodule Day2 do
  def day2 do
    input = String.trim_trailing(File.read! "input/input2.txt")
    output1 = calc_checksum(input)
    IO.puts "Checksum part 1: #{output1}"
  end

  ########
  # Part 1
  def calc_checksum(str) do
    String.split(str, "\n")
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
end
