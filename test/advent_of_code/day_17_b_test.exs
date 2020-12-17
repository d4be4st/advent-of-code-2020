defmodule AdventOfCode.Day17bTest do
  use ExUnit.Case

  import AdventOfCode.Day17b

  test "part1" do
    input = "test/support/input17.txt"
    result = part2(input)

    assert result == 848
  end
end
