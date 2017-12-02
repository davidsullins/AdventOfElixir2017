# day1.ex
# captcha

defmodule Day1 do
  ########
  # Part 1
  def captcha1(str) do
    last_char = String.last(str)
    sum_pairs(str, last_char, 0)
  end

  defp sum_pairs(<<c::integer, rest::binary>>, <<c>>, acc) do
    # code point 48 is '0', 49 is '1', etc
    num = c - 48
    sum_pairs(rest, <<c>>, acc + num)
  end

  defp sum_pairs(<<c2, rest::binary>>, _, acc) do
    sum_pairs(rest, <<c2>>, acc)
  end

  defp sum_pairs(_, _, acc) do
    acc
  end

  ########
  # Part 2
  def captcha2(str) do
    len = String.length(str)
    half_len = div(len, 2)
    rotated_str = String.slice(str, half_len, half_len) <> String.slice(str, 0, half_len)
    sum_pairs2(str, rotated_str, 0)
  end

  defp sum_pairs2(<<c::integer, rest1::binary>>, <<c::integer, rest2::binary>>, acc) do
    # code point 48 is '0', 49 is '1', etc
    num = c - 48
    sum_pairs2(rest1, rest2, acc + num)
  end

  defp sum_pairs2(<<_, rest1::binary>>, <<_, rest2::binary>>, acc) do
    sum_pairs2(rest1, rest2, acc)
  end

  defp sum_pairs2(_, _, acc) do
    acc
  end
end

