defmodule Advent2017Test do
  use ExUnit.Case

  test "day1 part 1" do
    assert Day1.captcha1("1122") == 3
    assert Day1.captcha1("1111") == 4
    assert Day1.captcha1("1234") == 0
    assert Day1.captcha1("91212129") == 9
  end

  test "day1 part 2" do
    assert Day1.captcha2("1122") == 0
    assert Day1.captcha2("1111") == 4
    assert Day1.captcha2("1234") == 0
    assert Day1.captcha2("91212129") == 6
  end

  test "day2 part 1" do
    assert Day2.calc_line_range("5 1 9 5\n") == 8
    assert Day2.calc_line_range(" 7 5 3") == 4
    assert Day2.calc_line_range("2 4 6 8") == 6

    input = "5 1 9 5\n7 5 3\n2 4 6 8\n"
    assert Day2.calc_checksum(input) == 18
  end

end
