defmodule AdventOfCode.Day14 do
  use Bitwise

  alias AdventOfCode.Utils

  def part1(args) do
    args
    |> Utils.parse_input
    |> Enum.reduce({%{}, {0, 0}}, &run_line1/2)
    |> sum
  end

  def part2(args) do
    args
    |> Utils.parse_input
    |> Enum.reduce({%{}, 0}, &run_line2/2)
    |> sum
  end

  def run_line1(line, {memory, mask}) do
    case String.slice(line, 0..2) do
      "mas" -> 
        {memory, set_mask1(line)}
      "mem" ->
        {set_memory1(line, memory, mask), mask}
    end
  end

  def set_mask1(line) do
    mask = 
      line
      |> String.split(" = ")
      |> List.last

    and_mask = String.replace(mask, "X", "1") |> String.to_integer(2)
    or_mask = String.replace(mask, "X", "0") |> String.to_integer(2)

    {and_mask, or_mask}
  end

  def set_memory1(line, memory, {and_mask, or_mask}) do
    parsed = Regex.named_captures(~r/mem\[(?<address>\d+)\] = (?<number>\d+)/, line)
    number = String.to_integer(parsed["number"])
    new_number = (number ||| or_mask) &&& and_mask
    Map.put(memory, parsed["address"], new_number)
  end

  def run_line2(line, {memory, mask}) do
    case String.slice(line, 0..2) do
      "mas" -> 
        {memory, set_mask2(line)}
      "mem" ->
        {set_memory2(line, memory, mask), mask}
    end
  end

  def set_mask2(line) do
    mask = 
      line
      |> String.split(" = ")
      |> List.last

    or_mask = String.replace(mask, "X", "0") |> String.to_integer(2)

    xcount =
      mask
      |> String.graphemes
      |> Enum.count(fn c -> c == "X" end)

    mask = String.replace(mask, "0", "1")

    masks =
      for i <- (0..xcount+1) do
        Integer.to_string(i, 2)
        |> String.pad_leading(xcount, "0")
        |> String.graphemes
        |> Enum.reduce(mask, fn c, acc ->
          String.replace(acc, "X", c, global: false)
        end)
        |> String.to_integer(2)
      end

    {or_mask, masks}
  end

  def set_memory2(line, memory, {or_mask, masks}) do
    parsed = Regex.named_captures(~r/mem\[(?<address>\d+)\] = (?<number>\d+)/, line)
    number = String.to_integer(parsed["address"])

    for mask <- masks do
      IO.inspect(Integer.to_string(number, 2), label: "number")
      IO.inspect(Integer.to_string(or_mask, 2), label: "or mask")
      IO.inspect(Integer.to_string(mask, 2), label: "mask")
      IO.inspect(Integer.to_string(number ||| or_mask, 2), label: "OR")
      ((number ||| or_mask) &&& mask) |> Integer.to_string(2) |> IO.inspect label: "AND"
    end
    # Map.put(memory, parsed["address"], new_number)
  end

  def sum({memory, _mask}) do
    Enum.reduce(memory, 0, fn {address, value}, acc -> acc + value end)
  end
end
