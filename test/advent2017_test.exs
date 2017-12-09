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
    assert Day2.calc_checksum1(input) == 18
  end

  test "day2 part 2" do
    assert Day2.parse_line("5 1 9 5\n") == [5, 1, 9, 5]
    assert Day2.parse_line(" 7 5 3") == [7, 5, 3]
    assert Day2.parse_line("2 4 6 8") == [2, 4, 6, 8]

    assert Day2.find_div_pair([5, 9, 2, 8]) == 4
    assert Day2.find_div_pair([9, 4, 7, 3]) == 3
    assert Day2.find_div_pair([3, 8, 6, 5]) == 2

    input = "5 9 2 8\n9 4 7 3\n3 8 6 5\n"
    assert Day2.calc_checksum2(input) == 9
  end

  test "day3 part 1" do
    assert Day3.calc_manhattan_dist(1) == 0
    assert Day3.calc_manhattan_dist(12) == 3
    assert Day3.calc_manhattan_dist(23) == 2
    assert Day3.calc_manhattan_dist(1024) == 31
  end

  # Disabled test because it downloads from the web
  @tag :skip
  test "day3 part 2" do
    assert Day3.find_first_greater(1) == 2
    assert Day3.find_first_greater(2) == 4
  end

  test "day4 part 1" do
    assert Day4.is_valid_passphrase1("aa bb cc dd ee") == true
    assert Day4.is_valid_passphrase1("aa bb cc dd aa") == false
    assert Day4.is_valid_passphrase1("aa bb cc dd aaa") == true
  end

  test "day4 part 2" do
    assert Day4.is_valid_passphrase2("abcde fghij") == true
    assert Day4.is_valid_passphrase2("abcde xyz ecbad") == false
    assert Day4.is_valid_passphrase2("a ab abc abd abf abj") == true
    assert Day4.is_valid_passphrase2("iii oiii ooii oooi oooo") == true
    assert Day4.is_valid_passphrase2("oiii ioii iioi iiio") == false
  end

  test "day5 part 1" do
    assert Day5.count_steps1([0, 3, 0, 1, -3]) == 5
  end

  test "day5 part 2" do
    assert Day5.count_steps2_array([0, 3, 0, 1, -3]) == 10
    assert Day5.count_steps2_tuple([0, 3, 0, 1, -3]) == 10
    assert Day5.count_steps2_map([0, 3, 0, 1, -3]) == 10
  end

  test "day6 part 1" do
    assert Day6.find_cycle1([0, 2, 7, 0]) == 5
  end

  test "day6 part 2" do
    assert Day6.find_cycle2([0, 2, 7, 0]) == 4
  end

  test "day7 part 1" do
    assert Day7.find_bottom([
      "pbga (66)",
      "xhth (57)",
      "ebii (61)",
      "havc (66)",
      "ktlj (57)",
      "fwft (72) -> ktlj, cntj, xhth",
      "qoyq (66)",
      "padx (45) -> pbga, havc, qoyq",
      "tknk (41) -> ugml, padx, fwft",
      "jptl (61)",
      "ugml (68) -> gyxo, ebii, jptl",
      "gyxo (61)",
      "cntj (57)"]) == "tknk"
  end

end
