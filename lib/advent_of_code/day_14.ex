defmodule AdventOfCode.Day14 do
  use Bitwise

  alias AdventOfCode.Utils

  def part1(args) do
    args
    |> Utils.parse_input()
    |> Enum.reduce({%{}, {0, 0}}, &run_line1/2)
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
      |> List.last()

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

  def part2(args) do
    args
    |> Utils.parse_input()
    |> Enum.reduce({%{}, 0}, &run_line2/2)
    |> sum
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
    line
    |> String.split(" = ")
    |> List.last()
    |> String.graphemes()
  end

  def set_memory2(line, memory, mask) do
    parsed = Regex.named_captures(~r/mem\[(?<address>\d+)\] = (?<number>\d+)/, line)
    number = String.to_integer(parsed["number"])

    address = address(parsed["address"], mask)
    count = 
      address
      |> String.graphemes
      |> Enum.count(fn x -> x == "X" end)

    Enum.reduce((0..floor(:math.pow(2, count))), memory, fn index, acc ->
      current_address =
        index
        |> Integer.to_string(2)
        |> String.pad_leading(count, "0")
        |> String.graphemes
        |> Enum.reduce(address, fn i, add -> 
          String.replace(add, "X", i, global: false)
        end)
        |> String.to_integer(2)

      Map.put(acc, current_address, number)
    end)
  end

  def address(address, mask) do
    address
    |> String.to_integer()
    |> Integer.to_string(2)
    |> String.pad_leading(36, "0")
    |> String.graphemes()
    |> Enum.with_index
    |> Enum.reduce([], fn {x, index}, acc ->
      case Enum.at(mask, index) do
        "0" -> [x | acc]
        "1" -> ["1" | acc]
        "X" -> ["X" | acc]
      end
    end)
    |> Enum.reverse
    |> Enum.join
  end

  def sum({memory, _mask}) do
    Enum.reduce(memory, 0, fn {_address, value}, acc -> acc + value end)
  end
end
