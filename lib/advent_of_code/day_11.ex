defmodule AdventOfCode.Day11 do
  alias AdventOfCode.Utils

  def part1(args) do
    args
    |> Utils.parse_input()
    |> Utils.to_matrix()
    |> start(4, &neighbourgs1/2)
  end

  def part2(args) do
    args
    |> Utils.parse_input()
    |> Utils.to_matrix()
    |> start(5, &neighbourgs2/2)
  end


  def start(matrix, count, fun) do
    case run_iterations(matrix, count, fun) do
      {new_matrix, true} ->
        start(new_matrix, count, fun)

      {new_matrix, false} ->
        Enum.count(new_matrix, fn {_cords, value} -> value == "#" end)
    end
  end

  def run_iterations(matrix, count, fun) do
    Enum.reduce(matrix, {%{}, false}, fn {cords, el}, {acc, changed} ->
      case el do
        "#" ->
          if change_for_occupied?(matrix, cords, count, fun) do
            {Map.put(acc, cords, "L"), true}
          else
            {Map.put(acc, cords, "#"), changed}
          end

        "L" ->
          if change_for_empty?(matrix, cords, fun) do
            {Map.put(acc, cords, "#"), true}
          else
            {Map.put(acc, cords, "L"), changed}
          end

        "." ->
          {Map.put(acc, cords, "."), changed}
      end
    end)
  end

  def change_for_occupied?(matrix, cords, count, fun) do
    Enum.count(fun.(matrix, cords), fn x -> x == "#" end) >= count
  end

  def change_for_empty?(matrix, cords, fun) do
    !Enum.any?(fun.(matrix, cords), fn x -> x == "#" end)
  end

  # part 1

  def neighbourgs1(matrix, {x, y}) do
    for i <- (x - 1)..(x + 1) do
      for j <- (y - 1)..(y + 1) do
        if !(i == x && j == y) do
          Map.get(matrix, {i, j}, ".")
        else
          "."
        end
      end
    end
    |> List.flatten()
  end

  # part 2
  def neighbourgs2(matrix, {x, y}) do
    for i <- (x - 1)..(x + 1) do
      for j <- (y - 1)..(y + 1) do
        if !(i == x && j == y) do
          find_neighbourg(matrix, {x, y}, {x - i, y - j})
        else
          "."
        end
      end
    end
    |> List.flatten()
  end

  def find_neighbourg(matrix, {x, y}, {i, j}) do
    case Map.get(matrix, {x + i, y + j}, nil) do
      "." -> find_neighbourg(matrix, {x + i, y + j}, {i, j})
      nil -> "."
      value -> value
    end
  end

end
