defmodule AdventOfCode.Day09Test do
  use ExUnit.Case

  import AdventOfCode.Day09

  alias AdventOfCode.Utils.HashList

  test "part1" do
    input = {"test/support/input09.txt", 5}
    result = part1(input)

    assert result == 127
  end

  test "part2" do
    input = {"test/support/input09.txt", 127}
    result = part2(input)

    assert result == 62
  end

  test "find nonmatching number" do
    list = %HashList{ list: %{0 => 1, 1 => 3, 2 => 1, 3 => 2, 4 => 4, 5 => 10}, count: 6 }
    assert find_nonmatching_number(list, 0, 4) == 10

    list = %HashList{ list: %{0 => 1, 1 => 3, 2 => 1, 3 => 2, 4 => 4, 5 => 6}, count: 6 }
    assert find_nonmatching_number(list, 0, 4) == :stop
  end

  test "check preamble numbers" do
    list = %HashList{ list: %{0 => 1, 1 => 3, 2 => 1, 3 => 2, 4 => 4} }
    assert check_preamble_numbers(list, 0, 4) == {:match, 4}

    list = %HashList{ list: %{0 => 1, 1 => 3, 2 => 1, 3 => 2, 4 => 10} }
    assert check_preamble_numbers(list, 0, 4) == {:next, 10}
  end

  test "check preamble pair" do
    list = %HashList{ list: %{0 => 1, 1 => 3, 2 => 1, 3 => 2, 4 => 4} }
    assert check_preamble_pair(list, 0, 1, 4, 4) == {:match, 4}

    list = %HashList{ list: %{0 => 1, 1 => 3, 2 => 1, 3 => 2, 4 => 10} }
    assert check_preamble_pair(list, 0, 1, 4, 10) == {:next, 10}
  end

  test "check number" do
    list = %HashList{ list: %{0 => 1, 1 => 3, 2 => 1, 3 => 2, 4 => 4} }
    assert check_number(list, 0, 2, 4) == :next
    assert check_number(list, 0, 3, 4) == :next
    assert check_number(list, 0, 1, 4) == :match
  end

  test "find contiguous" do
    list = %HashList{ list: %{0 => 1, 1 => 3, 2 => 1, 3 => 2, 4 => 4}, count: 5 }
    assert find_contiguous(list, 0, 5) == 4
  end

  test "sum contiguous" do
    list = %HashList{ list: %{0 => 1, 1 => 3, 2 => 1, 3 => 2, 4 => 4} }

    assert sum_contiguous(list, 0, 0, 5) == :match
    assert sum_contiguous(list, 0, 0, 2) == :next
    assert sum_contiguous(list, 1, 0, 6) == :match
  end
end
