defmodule AdventOfCode.Day14Test do
  use ExUnit.Case

  import AdventOfCode.Day14

  test "part1" do
    input = "test/support/input14.txt"
    result = part1(input)

    assert result == 165
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
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

  test "set mask 2" do
    input = "mask = 000000000000000000000000000000X1001X"

    assert set_mask2(input) == {18, [68719476702, 68719476703, 68719476734, 68719476735]}
  end

  test "set memory 2" do
    masks = {18, [68719476702, 68719476703, 68719476734, 68719476735]}
    input = "mem[42] = 100"

    assert set_memory2(input, %{}, masks) == %{}
  end
end
