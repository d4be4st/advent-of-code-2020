defmodule AdventOfCode.Day06 do
  alias AdventOfCode.Utils

  def part1(args) do
    args
    |> Utils.parse_input()
    |> parse
    |> sum_any_group
  end

  def part2(args) do
    args
    |> Utils.parse_input()
    |> parse
    |> sum_all_group
  end

  def parse(lines) do
    lines
    |> Enum.reduce([%{}], fn line, acc ->
      parse_line(line, acc)
    end)
  end

  def parse_line(line, [head | tail] = acc) do
    case line do
      "" ->
        [%{} | acc]

      answers ->
        head =
          answers
          |> String.graphemes()
          |> Enum.reduce(head, fn c, current ->
            current
            |> Map.update(c, 1, &(&1 + 1))
          end)
          |> Map.update("people", 1, &(&1 + 1))

        [head | tail]
    end
  end

  def sum_any_group(groups) do
    groups
    |> Enum.reduce(0, fn group, sum ->
      keys =
        group
        |> Map.keys()
        |> Enum.count()

      keys - 1 + sum
    end)
  end

  def sum_all_group(groups) do
    groups
    |> Enum.reduce(0, fn group, sum ->
      count = group["people"]

      keys =
        group
        |> Enum.filter(fn {k, v} -> v == count && k != "people" end)
        |> Enum.count

      keys + sum
    end)
  end
end
