defmodule AdventOfCode.Day02 do
  alias AdventOfCode.Utils

  def part1(args) do
    args
    |> Utils.parse_input
    |> count_valid
  end

  def part2(args) do
    args
    |> Utils.parse_input
    |> count_valid2
  end

  def count_valid(stream) do
    stream
    |> Enum.reduce(0, fn line, sum ->
      validity =
        line
        |> parse
        |> is_valid?
      if validity, do: sum + 1, else: sum
    end)
  end

  def count_valid2(stream) do
    stream
    |> Enum.reduce(0, fn line, sum ->
      validity =
        line
        |> parse
        |> is_valid2?
      if validity, do: sum + 1, else: sum
    end)
  end

  def parse(line) do
    Regex.named_captures(~r/(?<min>\d+)-(?<max>\d+) (?<character>\w): (?<password>\w+)/, line)
  end

  def is_valid?(parsed_line) do
    count =
      parsed_line["password"]
      |> String.graphemes
      |> Enum.count(fn c -> c == parsed_line["character"] end)

    count >= String.to_integer(parsed_line["min"]) && count <= String.to_integer(parsed_line["max"])
  end

  def is_valid2?(parsed_line) do
    graphemes = String.graphemes(parsed_line["password"])

    min = Enum.at(graphemes, String.to_integer(parsed_line["min"]) - 1) == parsed_line["character"]
    max = Enum.at(graphemes, String.to_integer(parsed_line["max"]) - 1) == parsed_line["character"]

    min && !max || !min && max
  end
end
