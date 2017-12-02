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
end