# day5.ex

defmodule Day5 do
  @moduledoc """
  Day 5, count steps through maze
  Part 1: move the specified number of steps with post-increment
  Part 2: like part 1, but if the specified number of steps is >= 3, post-decrement instead

  I used arrays, which apparently don't get used much in Elixir. Is there a more idiomatic solution?
  """

  def day5 do
    input = "input/input5.txt"
            |> File.read!
            |> String.split
            |> Enum.map(&String.to_integer(&1))

    {time1, steps1} = :timer.tc(Day5, :count_steps1, [input])
    IO.puts "steps (part 1): #{steps1}; #{time1 / 1_000_000}s"
    {time2, steps2} = :timer.tc(Day5, :count_steps2_array, [input])
    IO.puts "steps (part 2, array): #{steps2}; #{time2 / 1_000_000}s"
    {time2, steps2} = :timer.tc(Day5, :count_steps2_tuple, [input])
    IO.puts "steps (part 2, tuple): #{steps2}; #{time2 / 1_000_000}s"
    {time2, steps2} = :timer.tc(Day5, :count_steps2_map, [input])
    IO.puts "steps (part 2, map): #{steps2}; #{time2 / 1_000_000}s"
  end

  ########
  # Part 1
  def count_steps1(input) do
    input
    |> :array.from_list
    |> jump1(0, 1)
  end

  defp jump1(maze, pos, step_count) do
    offset = :array.get(pos, maze)
    new_pos = pos + offset
    new_maze = :array.set(pos, offset + 1, maze)
    if new_pos >= :array.size(maze) or new_pos < 0, do: step_count, else: jump1(new_maze, new_pos, step_count + 1)
  end

  ########
  # Part 2
  def count_steps2_array(input) do
    input
    |> :array.from_list
    |> jump2_array(0, 1)
  end

  defp jump2_array(maze, pos, step_count) do
    offset = :array.get(pos, maze)
    new_pos = pos + offset
    new_offset = if offset > 2, do: offset - 1, else: offset + 1
    new_maze = :array.set(pos, new_offset, maze)
    if new_pos >= :array.size(maze) or new_pos < 0, do: step_count, else: jump2_array(new_maze, new_pos, step_count + 1)
  end

  def count_steps2_tuple(input) do
    input
    |> List.to_tuple
    |> jump2_tuple(0, 1)
  end

  defp jump2_tuple(maze, pos, step_count) do
    offset = elem(maze, pos)
    new_pos = pos + offset
    new_offset = if offset > 2, do: offset - 1, else: offset + 1
    new_maze = put_elem(maze, pos, new_offset)
    if new_pos >= tuple_size(maze) or new_pos < 0, do: step_count, else: jump2_tuple(new_maze, new_pos, step_count + 1)
  end

  def count_steps2_map(input) do
    0..length(input)
    |> Enum.zip(input)
    |> Enum.into(%{})
    |> jump2_map(0, 1)
  end

  defp jump2_map(maze, pos, step_count) do
    offset = maze[pos]
    new_pos = pos + offset
    new_offset = if offset > 2, do: offset - 1, else: offset + 1
    new_maze = Map.put(maze, pos, new_offset)
    if new_pos >= map_size(maze) or new_pos < 0, do: step_count, else: jump2_map(new_maze, new_pos, step_count + 1)
  end
end
