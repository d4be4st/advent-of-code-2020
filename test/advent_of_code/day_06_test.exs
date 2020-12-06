defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  test "part1" do
    input = "test/support/input06.txt"
    result = part1(input)

    assert result == 11
  end

  test "part2" do
    input = "test/support/input06.txt"
    result = part2(input)

    assert result == 6
  end

  test "parse 'abc'" do
    line = "abc"

    assert parse_line(line, [%{}]) == [%{"a" => 1, "b" => 1, "c" => 1, "people" => 1}]
  end

  test "parse 'a' 'a' 'a'" do
    line = "a"
    acc = parse_line(line, [%{}])
    acc = parse_line(line, acc)

    assert parse_line(line, acc) == [%{"a" => 3, "people" => 3}]
  end

  test "adding new head" do
    acc = parse_line("a", [%{}])

    assert parse_line("", acc) == [%{}, %{"a" => 1, "people" => 1}]
  end

  test "sum group" do
    groups = [%{"a" => 1, "people" => 1}, %{"a" => 1, "b" => 3, "c" => 2, "people" => 3}]

    assert sum_any_group(groups) == 4
  end
end
