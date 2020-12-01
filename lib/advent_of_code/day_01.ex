defmodule AdventOfCode.Day01 do
  alias AdventOfCode.Utils
  alias AdventOfCode.Utils.HashList

  def part1(args) do
    args
    |> Utils.parse_input()
    |> Stream.map(&String.to_integer/1)
    |> Utils.to_hash_list()
    |> calculate1
  end

  def part2(args) do
    args
    |> Utils.parse_input()
    |> Stream.map(&String.to_integer/1)
    |> Utils.to_hash_list()
    |> calculate2
  end

  defp calculate1(hash_list) do
    try do
      for i <- 0..(hash_list.count - 1) do
        for j <- 1..(hash_list.count - 1) do
          if HashList.get(hash_list, i) + HashList.get(hash_list, j) == 2020 do
            iel = HashList.get(hash_list, i)
            jel = HashList.get(hash_list, j)
            if iel + jel == 2020 do
              throw(iel * jel)
            end
          end
        end
      end
    catch
      n -> n
    end
  end

  defp calculate2(hash_list) do
    try do
      for i <- 0..(hash_list.count - 1) do
        for j <- 1..(hash_list.count - 1) do
          for k <- 1..(hash_list.count - 1) do
            iel = HashList.get(hash_list, i)
            jel = HashList.get(hash_list, j)
            kel = HashList.get(hash_list, k)
            if iel + jel + kel == 2020 do
              throw(iel * jel * kel)
            end
          end
        end
      end
    catch
      n -> n
    end
  end
end
