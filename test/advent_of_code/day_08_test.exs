defmodule AdventOfCode.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Day08

  test "part1" do
    input = "test/support/input08.txt"
    result = part1(input)

    assert result == 5
  end

  test "part2" do
    input = "test/support/input08.txt"
    result = part2(input)

    assert result == 8 
  end
end
