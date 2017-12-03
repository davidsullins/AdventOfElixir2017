# day3.ex
# spiral numbers

defmodule Day3 do
  def day3 do
    input = File.read!("input/input3.txt")
            |> String.trim_trailing
            |> String.to_integer
    output1 = calc_manhattan_dist(input)
    IO.puts "Manhattan distance part 1: #{output1}"
  end

  ########
  # Part 1
  #
  # General explanation of this algorithm
  # Each ring's max number is the square of an odd integer
  # The inner ring's max is 1 (1^2)
  # The next ring's max is 9  (3^2)
  # The next ring's max is 25 (5^2)
  # etc..
  #
  # So we can identify a ring by the odd root. That gives us ring 1, 3, 5, 7, etc
  # Taking the square root of any number, rounding up to the next odd gives us the ring
  #
  # The length of a side is the odd root, which should be apparent by looking at the problem description
  # To find the distance to the center of the side:
  # * Take the difference from the ring max
  # * modulo 1/4 of the perimeter
  # * distance from 1/8 of the perimeter (the center of the side)
  #
  # Then just add 1/8 the perimeter to get the total Manhattan distance
  def calc_manhattan_dist(1), do: 0
  def calc_manhattan_dist(x) do
    root = find_sqrt_of_ring_max(x)
    quadrant_length = root - 1
    half_quadrant_length = div(quadrant_length, 2)
    dist_to_side_center = rem(root * root - x, quadrant_length) - half_quadrant_length |> abs
    dist_to_side_center + half_quadrant_length
  end

  # find the sqrt of the max number of the ring x is in
  defp find_sqrt_of_ring_max(x) do
    x
    |> :math.sqrt
    |> Float.ceil
    |> round
    |> find_next_highest_odd
  end

  defp find_next_highest_odd(x), do: if rem(x, 2) == 0, do: x + 1, else: x

end
