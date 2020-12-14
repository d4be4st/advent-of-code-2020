defmodule AdventOfCode.Day13 do
  alias AdventOfCode.Utils

  def part1(args) do
    args
    |> Utils.parse_input
    |> Enum.to_list
    |> find_nearest
  end

  def part2(args) do
    args
    |> Utils.parse_input
    |> Enum.to_list
    |> find_first_smth
  end

  def find_nearest([timestamp, buses]) do
    timestamp = String.to_integer(timestamp)
    {bus, ts} =
      buses
      |> parse_buses
      |> find_first_departure(timestamp)
      |> Enum.min_by(fn {_k, v} -> v end)

    (ts - timestamp) * bus
  end

  def parse_buses(buses) do
    buses
    |> String.split(",")
    |> Enum.filter(fn b -> b != "x" end)
    |> Enum.map(&String.to_integer/1)
  end

  def find_first_departure(buses, start_timestamp) do
    buses
    |> Enum.reduce(%{}, fn bus, acc ->
      timestamp = ceil(start_timestamp / bus) * bus
      Map.put(acc, bus, timestamp)
    end)
  end

  def find_first_smth([_ts, buses]) do
    buses
    |> String.split(",")
    |> Enum.with_index
    |> Enum.filter(fn {v, _} -> v != "x" end)
    |> Enum.map(fn {e, i} -> {String.to_integer(e), i} end)
    |> find_first_time
  end

  # Cobbled together chinese remainder theorem lmao glhf understanding
  def find_first_time(buses) do
    bigN = buses
    |> Enum.map(&(elem(&1, 0)))
    |> Enum.reduce(1, &Kernel.*/2)

    x = buses
    |> Enum.map(fn {n, a} ->
      ni = Integer.floor_div(bigN, n)
      xi = find_xi(ni, n, 1)
      ni * xi * a
    end)
    |> Enum.sum()
    |> Kernel.rem(bigN)

    bigN - x
  end

  def find_xi(ni, n, x) do
    case rem(x * ni, n) do
      1 -> x
      _ -> find_xi(ni, n, x + 1)
    end
  end
end
