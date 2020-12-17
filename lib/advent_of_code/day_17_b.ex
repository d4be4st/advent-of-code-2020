defmodule AdventOfCode.Day17b do
  alias AdventOfCode.Utils

  def part2(args) do
    args
    |> Utils.parse_input()
    |> Utils.to_4Dmatrix()
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

    {{minx, _, _, _}, {maxx, _, _, _}} = Enum.min_max_by(cords, fn {x, _, _, _} -> x end)
    {{_, miny, _, _}, {_, maxy, _, _}} = Enum.min_max_by(cords, fn {_, y, _, _} -> y end)
    {{_, _, minz, _}, {_, _, maxz, _}} = Enum.min_max_by(cords, fn {_, _, z, _} -> z end)
    {{_, _, _, minw}, {_, _, _, maxw}} = Enum.min_max_by(cords, fn {_, _, _, w} -> w end)

    {matrix, {{minx - 1, maxx + 1}, {miny - 1, maxy + 1}, {minz - 1, maxz + 1}, {minw - 1, maxw + 1}}}
  end

  def count(matrix) do
    Enum.count(matrix, fn {_cords, value} -> value == "#" end)
  end

  def run_cycle({matrix, {{minx, maxx}, {miny, maxy}, {minz, maxz}, {minw, maxw}}}) do
    for(i <- minx..maxx, j <- miny..maxy, k <- minz..maxz, l <- minw..maxw, into: %{}) do
      cords = {i, j, k, l}

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

  def neighbourgs(matrix, {x, y, z, w}) do
    for i <- (x - 1)..(x + 1) do
      for j <- (y - 1)..(y + 1) do
        for k <- (z - 1)..(z + 1) do
          for l <- (w - 1)..(w + 1) do
            if !(i == x && j == y && k == z && l == w) do
              Map.get(matrix, {i, j, k, l}, ".")
            else
              "."
            end
          end
        end
      end
    end
    |> List.flatten()
  end
end
