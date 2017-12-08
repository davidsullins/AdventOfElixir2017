# day6.ex
# awalé

defmodule Day6 do
  @moduledoc """
  Day 6, sow seeds like awalé, always starting from the pit with the most seeds, until we see a state we've seen before
  Part 1: count how many times we sow until we encounter a previous state
  Part 2: count how long the cycle is
  """

  def day6 do
    board = "input/input6.txt"
            |> File.read!
            |> String.split
            |> Enum.map(&String.to_integer(&1))
    sow_times = find_cycle1(board)
    sow_loop_length = find_cycle2(board)
    IO.puts("sowed seeds #{sow_times} times until cycle (part 1)")
    IO.puts("cycle length (part 2): #{sow_loop_length}")
  end

  ########
  # Part 1
  def find_cycle1(board) do
    board_size = length(board)
    find_cycle1(board, MapSet.new, 0, board_size)
  end

  defp find_cycle1(board, states, sow_times, board_size) do
    if MapSet.member?(states, board) do
      sow_times
    else
      sow_count = Enum.max(board)
      starting_pit = Enum.find_index(board, &(&1 == sow_count))

      board
      |> Enum.with_index
      |> Enum.map(&(sow_seeds(&1, sow_count, starting_pit, board_size)))
      |> find_cycle1(MapSet.put(states, board), sow_times + 1, board_size)
    end
  end

  # Tell how many seeds will be in a pit after sowing, given the count of seeds to sow and a starting pit
  defp sow_seeds({current_count, _}, 0, _, _), do: current_count
  defp sow_seeds({current_count, pit}, sow_count, starting_pit, board_size) do
    # number of times we loop all the way around the board
    loops = div(sow_count, board_size)
    # rotate so the pit after the starting pit is pit 0
    rotated_pit = if pit < starting_pit, do: pit - starting_pit + board_size, else: pit - starting_pit
    cond do
      rotated_pit == 0 ->
        loops
      rotated_pit <= rem(sow_count, board_size) ->
        current_count + loops + 1
      true ->
        current_count + loops
    end
  end

  ########
  # Part 2
  def find_cycle2(board) do
    board_size = length(board)
    find_cycle2(board, Map.new, 0, board_size)
  end

  defp find_cycle2(board, times, sow_times, board_size) do
    if Map.has_key?(times, board) do
      sow_times - times[board]
    else
      sow_count = Enum.max(board)
      starting_pit = Enum.find_index(board, &(&1 == sow_count))

      board
      |> Enum.with_index
      |> Enum.map(&(sow_seeds(&1, sow_count, starting_pit, board_size)))
      |> find_cycle2(Map.put(times, board, sow_times), sow_times + 1, board_size)
    end
  end
end
