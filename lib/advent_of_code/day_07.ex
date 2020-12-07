defmodule AdventOfCode.Day07 do
  alias AdventOfCode.Utils
  alias AdventOfCode.Utils.Tree

  def part1(args) do
    args
    |> Utils.parse_input()
    |> Enum.map(&parse_line/1)
    |> create_tree
    |> find_parents_of("shiny gold", MapSet.new())
    |> Enum.count()
  end

  def part2(args) do
    args
    |> Utils.parse_input()
    |> Enum.map(&parse_line/1)
    |> create_tree
    |> count_children_of("shiny gold")
  end

  def find_parents_of(tree, name, parents) do
    if tree[name].parents == [] do
      parents
    else
      Enum.reduce(tree[name].parents, parents, fn p, acc ->
        acc = MapSet.put(acc, p)
        find_parents_of(tree, p, acc)
      end)
    end
  end

  # 1 + (1 * (3 * 1) + (4 * 1)) + 2 + (2 * ((5 *1) + (6 * 1) )
  # 1 + 1*7 + 2 + 2*11
  def count_children_of(tree, name) do
    count = 0

    Enum.sum(
      for {child, size} <- tree[name].children do
        count_children_of(tree, child, size)
      end
    )
  end

  def count_children_of(tree, name, size) do
    if tree[name].children == %{nil: nil} do
      String.to_integer(size)
    else
      String.to_integer(size) +
        String.to_integer(size) *
          Enum.sum(
            for {child, size} <- tree[name].children do
              count_children_of(tree, child, size)
            end
          )
    end
  end

  def create_tree(parsed_lines) do
    parsed_lines
    |> Enum.reduce(%{}, &add_to_tree/2)
  end

  def add_to_tree(line, tree) do
    tree = Tree.add_children(tree, line["name"], line["children"])

    Enum.reduce(line["children"], tree, fn {child, _count}, t ->
      if child != nil do
        Tree.add_parent(t, child, line["name"])
      else
        t
      end
    end)
  end

  def parse_line(line) do
    parsed = Regex.named_captures(~r/(?<name>.*) bags contain (?<children>.*)./, line)

    Map.update!(parsed, "children", &parse_children/1)
  end

  def parse_children(children_string) do
    children_string
    |> String.split(", ")
    |> Enum.reduce(%{}, fn c, acc ->
      captures = Regex.named_captures(~r/(?<count>\d) (?<name>.*) bags?/, c)
      Map.put(acc, captures["name"], captures["count"])
    end)
  end
end
