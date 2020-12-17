defmodule AdventOfCode.Day17Test do
  use ExUnit.Case

  import AdventOfCode.Day17

  test "part1" do
    input = "test/support/input17.txt"
    result = part1(input)

    assert result == 112
  end
end
