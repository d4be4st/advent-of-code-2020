defmodule AdventOfCode.Day14Test do
  use ExUnit.Case

  import AdventOfCode.Day14

  alias AdventOfCode.Utils

  test "part1" do
    input = "test/support/input14.txt"
    result = part1(input)

    assert result == 165
  end

  test "part2" do
    input = "test/support/input14_2.txt"
    result = part2(input)

    assert result == 208
  end

  test "set mask" do
    input = "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"

    assert set_mask1(input) == {68_719_476_733, 64}
  end

  test "set_memory" do
    assert set_memory1("mem[8] = 11", %{}, {68_719_476_733, 64}) == %{"8" => 73}
    assert set_memory1("mem[7] = 101", %{}, {68_719_476_733, 64}) == %{"7" => 101}
    assert set_memory1("mem[8] = 0", %{}, {68_719_476_733, 64}) == %{"8" => 64}
  end

  test "set memory 2" do
    mask = "000000000000000000000000000000X1001X" |> String.graphemes
    input = "mem[42] = 100"

    assert set_memory2(input, %{}, mask) == %{26 => 100, 27 => 100, 58 => 100, 59 => 100}
  end

  test "address" do
    mask = "000000000000000000000000000000X1001X" |> String.graphemes

    assert address("42", mask) == "000000000000000000000000000000X1101X"
  end
end
