defmodule AdventOfCode.Day16 do
  alias AdventOfCode.Utils

  def part1({fields_input, _, nearby_input}) do
    fields =
      fields_input
      |> Utils.parse_input
      |> parse_fields

    nearby_input
    |> Utils.parse_input
    |> Enum.reduce([], fn line, acc -> find_missing(line, fields) ++ acc end)
    |> Enum.sum
  end

  def part2(_args) do
  end

  def parse_fields(stream) do
    Enum.reduce(stream, %{}, fn line, acc ->
      line = Regex.named_captures(~r/(?<field>.*): (?<min1>\d+)-(?<max1>\d+) or (?<min2>\d+)-(?<max2>\d+)/, line)
      acc
      |> fill(line["min1"], line["max1"], line["field"])
      |> fill(line["min2"], line["max2"], line["field"])
    end)
  end

  def fill(acc, min, max, field) do
    Enum.reduce((String.to_integer(min)..String.to_integer(max)), acc, fn i, acc1 ->
      Map.update(acc1, i, [field], &([field | &1]))
    end)
  end

  def find_missing(line, fields) do
    numbers =
      line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    Enum.filter(numbers, fn x ->
      !Map.get(fields, x)
    end)
  end
end
