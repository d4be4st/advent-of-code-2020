defmodule AdventOfCode.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Day10

  test "part1" do
    input = "test/support/input10.txt"
    result = part1(input)

    assert result == 220
  end

  test "part2" do
    input = "test/support/input10.txt"
    result = part2(input)

    assert result == 19208
  end

  test "find differences" do
    list = [0, 16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4] |> Enum.sort 

    output = %{1 => 0, 3 => 0}
    assert find_differences(list, output) == %{1 => 7, 3 => 5}
  end

  test "find subsets" do
    list = [1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19]

    assert find_subsets(list) == [[1], [7,6,5,4], [12,11,10],[16,15], [19]]
  end

  test "sum subsets" do
    subsets = [[1], [7,6,5,4], [12,11,10],[16,15], [19]]

    assert sum(subsets) == 8
  end
end
