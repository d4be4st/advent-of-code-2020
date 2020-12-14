defmodule AdventOfCode.Day13Test do
  use ExUnit.Case

  import AdventOfCode.Day13

  test "part1" do
    input = "test/support/input13.txt"
    result = part1(input)

    assert result == 295
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end

  test "find first departure" do
    buses = [7,13,59,31,19] 
    assert find_first_departure(buses, 939) == %{
      7 => 945, 13 => 949, 59 => 944, 31 => 961, 19 => 950
    }
  end
end
