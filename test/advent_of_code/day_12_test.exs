defmodule AdventOfCode.Day12Test do
  use ExUnit.Case

  import AdventOfCode.Day12

  test "part1" do
    input = "test/support/input12.txt"
    result = part1(input)

    assert result == 25
  end

  test "part2" do
    input = "test/support/input12.txt"
    result = part2(input)

    assert result == 286
  end
end
