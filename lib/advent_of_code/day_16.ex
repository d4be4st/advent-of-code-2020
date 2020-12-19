defmodule AdventOfCode.Day16 do
  alias AdventOfCode.Utils
  alias AdventOfCode.Utils.HashList

  def part1({fields_input, _, nearby_input}) do
    fields =
      fields_input
      |> Utils.parse_input()
      |> parse_fields

    nearby_input
    |> Utils.parse_input()
    |> Enum.reduce([], fn line, acc -> find_missing(line, fields) ++ acc end)
    |> Enum.sum()
  end

  def part2({fields_input, your_input, nearby_input}) do
    fields =
      fields_input
      |> Utils.parse_input()
      |> parse_fields

    nearby_input
    |> Utils.parse_input()
    |> Enum.reduce(%{}, fn line, acc -> map_matching_fields(line, acc, fields) end)
    |> reduce(%{})
    |> sum_departures(your_input)
  end

  def parse_fields(stream) do
    Enum.reduce(stream, %{}, fn line, acc ->
      line =
        Regex.named_captures(
          ~r/(?<field>.*): (?<min1>\d+)-(?<max1>\d+) or (?<min2>\d+)-(?<max2>\d+)/,
          line
        )

      acc
      |> fill(line["min1"], line["max1"], line["field"])
      |> fill(line["min2"], line["max2"], line["field"])
    end)
  end

  def fill(acc, min, max, field) do
    Enum.reduce(String.to_integer(min)..String.to_integer(max), acc, fn i, acc1 ->
      Map.update(acc1, i, [field], &[field | &1])
    end)
  end

  def find_missing(line, fields) do
    numbers =
      line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    Enum.filter(numbers, fn x ->
      !Map.get(fields, x)
    end)
  end

  def prepare_input(input, fields) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {number, index}, acc ->
      field = Map.get(fields, number)
      Map.update(acc, index, field, &(field ++ &1))
    end)
  end

  def map_matching_fields(line, map, fields) do
    input_fields = prepare_input(line, fields)
    invalid_field = Enum.find(input_fields, fn {_i, v} -> v == nil end)

    case invalid_field do
      {_, nil} ->
        map

      nil ->
        Enum.reduce(input_fields, map, fn {key, values}, acc ->
          Map.update(acc, key, values, fn v ->
            v -- (v -- values || [])
          end)
        end)
    end
  end

  def reduce(fields, new_fields) when fields == %{}, do: new_fields

  def reduce(fields, new_fields) do
    known_fields = Enum.filter(fields, fn {_, v} -> Enum.count(v) == 1 end) |> Map.new()
    new_fields = Map.merge(new_fields, known_fields)

    old_fields =
      Enum.reduce(fields, %{}, fn {index, values}, acc ->
        new_values = values -- List.flatten(Map.values(known_fields))

        if Enum.count(new_values) > 0 do
          Map.put(acc, index, new_values)
        else
          acc
        end
      end)

    reduce(old_fields, new_fields)
  end

  def sum_departures(fields, your_input) do
    input =
      your_input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Utils.to_hash_list

    departures = 
      Enum.filter(fields, fn {_index, arr} -> String.starts_with?(List.first(arr), "departure") end)

    Enum.reduce(departures, 1, fn {index, _}, sum -> HashList.get(input, index) * sum end)
  end
end
