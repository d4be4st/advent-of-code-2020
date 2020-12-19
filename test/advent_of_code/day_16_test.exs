defmodule AdventOfCode.Day16Test do
  use ExUnit.Case

  import AdventOfCode.Day16

  test "part1" do
    input = {"test/support/input16_1.txt", "", "test/support/input16_2.txt"}
    result = part1(input)

    assert result == 71
  end

  test "part2" do
    input = {"test/support/input16_3.txt", "11,12,13", "test/support/input16_4.txt"}
    result = part2(input)

    assert result == %{0 => ["row"], 1 => ["class"], 2 => ["seat"]}
  end

  test "parse fields" do
    input = "test/support/input16_1.txt" |> AdventOfCode.Utils.parse_input()

    assert parse_fields(input) == %{
             1 => ["class"],
             2 => ["class"],
             3 => ["class"],
             5 => ["class"],
             6 => ["row", "class"],
             7 => ["row", "class"],
             8 => ["row"],
             9 => ["row"],
             10 => ["row"],
             11 => ["row"],
             13 => ["seat"],
             14 => ["seat"],
             15 => ["seat"],
             16 => ["seat"],
             17 => ["seat"],
             18 => ["seat"],
             19 => ["seat"],
             20 => ["seat"],
             21 => ["seat"],
             22 => ["seat"],
             23 => ["seat"],
             24 => ["seat"],
             25 => ["seat"],
             26 => ["seat"],
             27 => ["seat"],
             28 => ["seat"],
             29 => ["seat"],
             30 => ["seat"],
             31 => ["seat"],
             32 => ["seat"],
             33 => ["seat", "row"],
             34 => ["seat", "row"],
             35 => ["seat", "row"],
             36 => ["seat", "row"],
             37 => ["seat", "row"],
             38 => ["seat", "row"],
             39 => ["seat", "row"],
             40 => ["seat", "row"],
             41 => ["row"],
             42 => ["row"],
             43 => ["row"],
             44 => ["row"],
             45 => ["seat"],
             46 => ["seat"],
             47 => ["seat"],
             48 => ["seat"],
             49 => ["seat"],
             50 => ["seat"]
           }
  end

  test "find missing" do
    line = "7,3,47"
    fields = %{3 => ["smth"], 47 => ["smth2"]}

    assert find_missing(line, fields) == [7]
  end

  test "reduce" do
    assert reduce(
      %{0 => ["row"], 1 => ["row", "class"], 2 => ["seat", "row", "class"]},
      %{}
    ) == %{0 => ["row"], 1 => ["class"], 2 => ["seat"]}
  end
end
