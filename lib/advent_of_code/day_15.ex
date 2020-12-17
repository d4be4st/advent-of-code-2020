defmodule AdventOfCode.Day15 do
  @stop1 2020
  @stop2 30000000

  def part1(args) do
    args
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> starting_run(%{}, 1)
  end

  def part2(_args) do
  end

  def starting_run([head | tail], result, index) do
    result = Map.put(result, head, [index])
    case tail do
      [] -> run(result, head, index + 1)
      _ -> starting_run(tail, result, index + 1)
    end
  end

  def run(_result, last, index) when index > @stop2 do
    last
  end

  def run(result, last, index) when index <= @stop2 do
    if rem(index, 1000) == 0, do: IO.inspect index
    case Map.get(result, last) do
      [_x] -> 
        result = Map.update(result, 0, [index], &([index | &1]))
        run(result, 0, index + 1)

      [x, y | _rest] ->
        number = x - y
        result = Map.update(result, number, [index], &([index | &1]))
        run(result, number, index + 1)
    end
  end
end
