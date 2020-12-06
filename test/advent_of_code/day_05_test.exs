defmodule AdventOfCode.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Day05

  test "part1" do
    input = "test/support/input05.txt"
    result = part1(input)

    assert result == 820
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result == 820
  end

  test "seat_id" do
    code = "FBFBBFFRLR"
    assert seat_id(code) == 357
  end

  test "find_seat rows" do
    codes = ["F", "B", "F", "B", "B", "F", "F"]
    row = {0, 127}
    col = {0, 7}
    assert find_seat(codes, row, col) == {44, 0}
  end

  test "find_seat cols" do
    codes = ["R", "L", "R"]
    row = {0, 127}
    col = {0, 7}
    assert find_seat(codes, row, col) == {0, 5}
  end
end
