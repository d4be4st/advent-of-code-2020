defmodule AdventOfCode.Day10 do
  alias AdventOfCode.Utils

  def part1(args) do
    args
    |> Utils.parse_input()
    |> Stream.map(&String.to_integer/1)
    |> Enum.sort()
    |> List.insert_at(0, 0)
    |> find_differences(%{1 => 0, 3 => 0})
    |> multiply
  end

  def part2(args) do
    args
    |> Utils.parse_input()
    |> Stream.map(&String.to_integer/1)
    |> Enum.sort()
    |> List.insert_at(0, 0)
    |> find_subsets
    |> sum
  end

  # part 1
  def find_differences([first, second | []], output) do
    output
    |> Map.update!(difference(first, second), &(&1 + 1))
    |> Map.update!(difference(second, second + 3), &(&1 + 1))
  end

  def find_differences([first, second | _] = list, output) do
    output =
      output
      |> Map.update!(difference(first, second), &(&1 + 1))

    [_ | rest] = list

    find_differences(rest, output)
  end

  def difference(first, second) do
    second - first
  end

  def multiply(%{1 => ones, 3 => threes}), do: ones * threes

  # part 2

  def find_subsets(list) do
    Enum.chunk_while(list, [], &chunk_fun/2, &chunk_after/1)
  end

  def sum(subsets) do
    Enum.reduce(subsets, 1, fn subset, acc ->
      count = Enum.count(subset) - 2

      cond do
        count == 1 ->
          acc * :math.pow(2, count)

        count == 2 ->
          acc * :math.pow(2, count)

        count == 3 ->
          acc * (:math.pow(2, count) - 1)
          
        count <= 0 ->
          acc
      end
    end)
  end

  def chunk_fun(element, []) do
    {:cont, [element]}
  end

  def chunk_fun(element, acc) do
    [head | tail] = acc

    if element - head == 1 do
      {:cont, [element | acc]}
    else
      {:cont, acc, [element]}
    end
  end

  def chunk_after(acc) do
    {:cont, acc, []}
  end
end
