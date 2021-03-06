defmodule AdventOfCode.Day17 do
  alias AdventOfCode.Utils

  def part1(args) do
    args
    |> Utils.parse_input()
    |> Utils.to_3Dmatrix()
    |> start(5)
    |> count
  end

  def start(matrix, count) do
    Enum.reduce(0..count, matrix, fn _index, matrix ->
      matrix
      |> find_bounds
      |> run_cycle
    end)
  end

  def find_bounds(matrix) do
    cords = Map.keys(matrix)

    {{minx, _, _}, {maxx, _, _}} = Enum.min_max_by(cords, fn {x, _, _} -> x end)
    {{_, miny, _}, {_, maxy, _}} = Enum.min_max_by(cords, fn {_, y, _} -> y end)
    {{_, _, minz}, {_, _, maxz}} = Enum.min_max_by(cords, fn {_, _, z} -> z end)

    {matrix, {{minx - 1, maxx + 1}, {miny - 1, maxy + 1}, {minz - 1, maxz + 1}}}
  end

  def count(matrix) do
    Enum.count(matrix, fn {_cords, value} -> value == "#" end)
  end

  def run_cycle({matrix, {{minx, maxx}, {miny, maxy}, {minz, maxz}}}) do
    for(i <- minx..maxx, j <- miny..maxy, k <- minz..maxz, into: %{}) do
      cords = {i, j, k}

      case Map.get(matrix, cords, ".") do
        "#" ->
          if change_for_active?(matrix, cords) do
            {cords, "."}
          else
            {cords, "#"}
          end

        "." ->
          if change_for_inactive?(matrix, cords) do
            {cords, "#"}
          else
            {cords, "."}
          end
      end
    end
  end

  def change_for_active?(matrix, cords) do
    count = neighbourgs(matrix, cords) |> Enum.count(fn x -> x == "#" end)
    !(count == 2 || count == 3)
  end

  def change_for_inactive?(matrix, cords) do
    count = neighbourgs(matrix, cords) |> Enum.count(fn x -> x == "#" end)
    count == 3
  end

  def neighbourgs(matrix, {x, y, z}) do
    for i <- (x - 1)..(x + 1) do
      for j <- (y - 1)..(y + 1) do
        for k <- (z - 1)..(z + 1) do
          if !(i == x && j == y && k == z) do
            Map.get(matrix, {i, j, k}, ".")
          else
            "."
          end
        end
      end
    end
    |> List.flatten()
  end
end
