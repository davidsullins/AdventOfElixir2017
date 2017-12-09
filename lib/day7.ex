# day7.ex
# tower of discs

defmodule Day7 do
  @moduledoc """
  Day 7, tower of discs
  Part 1: Find bottom of tree
  """
  def day7 do
    bottom = "input/input7.txt"
             |> File.read!
             |> String.split("\n", trim: true)
             |> find_bottom
    IO.puts("Part 1 bottom is #{bottom}")
  end

  ########
  # Part 1
  def find_bottom(lines) do
    tree = Map.new(lines, &parse_line(&1))
    parents = tree
              |> Map.keys
              |> Enum.sort
    children = tree
               |> Map.values
               |> List.flatten
               |> Enum.sort
    # The bottom is the one that appears as a key but not as a value
    find_list_diff(parents, children)
  end

  # Example
  # in:  "fwft (72) -> ktlj, cntj, xhth", %{}
  # out: {"fwft", ["ktlj", "cntj", "xhth"]}
  defp parse_line(line) do
    case String.split(line, "->") do
      [parent, children] -> {parent |> String.split |> hd, String.split(children, [",", " "], trim: true)}
      [parent] -> {parent |> String.split |> hd, []}
    end
  end

  defp find_list_diff([head | tail1], [head | tail2]), do: find_list_diff(tail1, tail2)
  defp find_list_diff([head1 | _], _), do: head1
end
