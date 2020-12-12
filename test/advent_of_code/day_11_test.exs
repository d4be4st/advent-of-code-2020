defmodule AdventOfCode.Day11Test do
  use ExUnit.Case

  import AdventOfCode.Day11

  test "part1" do
    input = "test/support/input11.txt"
    result = part1(input)

    assert result == 37
  end

  test "part2" do
    input = "test/support/input11.txt"
    result = part2(input)

    assert result == 26
  end

  test "run_iterations empty" do
    matrix = %{
      {0, 0} => "L", {0, 1} => ".", {0, 2} => ".",
      {1, 0} => "L", {1, 1} => "L", {1, 2} => "L",
      {2, 0} => ".", {2, 1} => "L", {2, 2} => "#"
    }

    assert run_iterations(matrix, 4, &neighbourgs1/2) ==
             {%{
                {0, 0} => "#", {0, 1} => ".", {0, 2} => ".",
                {1, 0} => "#", {1, 1} => "L", {1, 2} => "L",
                {2, 0} => ".", {2, 1} => "L", {2, 2} => "#"
              }, true}
  end

  test "run_iterations full" do
    matrix = %{
      {0, 0} => "#", {0, 1} => "#", {0, 2} => ".",
      {1, 0} => "#", {1, 1} => "#", {1, 2} => "L",
      {2, 0} => "#", {2, 1} => ".", {2, 2} => "#"
    }

    assert run_iterations(matrix, 4, &neighbourgs1/2) ==
             {%{
                {0, 0} => "#", {0, 1} => "#", {0, 2} => ".",
                {1, 0} => "L", {1, 1} => "L", {1, 2} => "L",
                {2, 0} => "#", {2, 1} => ".", {2, 2} => "#"
              }, true}
  end

  test "neighbourgs 1" do
    matrix = %{{0, 0} => "L", {0, 1} => ".", {1, 0} => "L", {1, 1} => "L"}

    assert neighbourgs1(matrix, {0, 0}) == [".", ".", ".", ".", ".", ".", ".", "L", "L"]
  end

  test "neighbourgs 2" do
    matrix = %{
      {0, 0} => "#", {0, 1} => ".", {0, 2} => "L",
      {1, 0} => ".", {1, 1} => ".", {1, 2} => "L",
      {2, 0} => "#", {2, 1} => ".", {2, 2} => "."
    }

    assert neighbourgs2(matrix, {0, 0}) == [".", "#", ".", "L", ".", ".", ".", ".", "."]
    assert neighbourgs2(matrix, {1, 1}) == [".", ".", "#", "L", ".", ".", "L", ".", "#"]
  end
end
