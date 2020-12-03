defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  test "part1" do
    input = "test/support/input02.txt"
    result = part1(input)

    assert result == 2
  end

  test "part2" do
    input = "test/support/input02.txt"
    result = part2(input)

    assert result == 1
  end
end
