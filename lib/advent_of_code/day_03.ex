defmodule AdventOfCode.Day03 do
  alias AdventOfCode.Utils

  def part1(args) do
    args
    |> Utils.parse_input()
    |> Stream.with_index()
    |> count_trees({1, 3})
    |> Map.get(:count)
  end

  def part2(args) do
    lines =
      args
        |> Utils.parse_input()
        |> Stream.with_index()

    Enum.reduce([{1,1}, {1,3}, {1,5}, {1,7}, {2,1}], 1, fn config, acc ->
      Map.get(count_trees(lines, config), :count) * acc
    end)
  end

  def count_trees(lines, config) do
    Enum.reduce(
      lines,
      %{count: 0, column_index: 0, column_width: nil, config: config},
      &count_tree_in_line/2
    )
  end

  def count_tree_in_line({line, row_index}, %{column_width: nil} = acc) do
    places = String.graphemes(line)
    column_width = Enum.count(places)
    acc = Map.put(acc, :column_width, column_width)
    count_tree_in_line({line, row_index}, acc)
  end

  def count_tree_in_line(
        {line, row_index},
        %{
          count: count,
          column_index: column_index,
          column_width: column_width,
          config: {row_jump, column_jump}
        } = acc
      ) do
    places = String.graphemes(line)

    {new_column_index, inc} =
      cond do
        row_index == 0 ->
          {column_index, 0}

        rem(row_index, row_jump) == 0 ->
          {new_column_index, new_place} = jump(places, column_index, column_jump, column_width)
          inc = if new_place == "#", do: 1, else: 0
          {new_column_index, inc}

        true ->
          {column_index, 0}
      end

    acc
    |> Map.put(:count, count + inc)
    |> Map.put(:column_index, new_column_index)
  end

  def jump(places, column_index, column_jump, column_width) do
    new_column_index = rem(column_index + column_jump, column_width)
    {new_column_index, Enum.at(places, new_column_index)}
  end
end
