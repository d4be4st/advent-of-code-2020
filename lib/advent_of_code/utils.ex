defmodule AdventOfCode.Utils do
  alias AdventOfCode.Utils.HashList

  def parse_input(file) do
    file
    |> File.stream!
    |> Stream.map(&String.trim/1)
  end

  def to_hash_list(stream) do
    stream
    |> Stream.with_index
    |> Enum.reduce(%HashList{}, fn {el, i}, hash_list -> 
      HashList.add(hash_list, el, i)
    end)
  end

  def to_matrix(stream) do
    stream
    |> Stream.with_index
    |> Enum.reduce(%{}, fn {line, i}, acc ->
      line
      |> String.graphemes
      |> Enum.with_index
      |> Enum.reduce(acc, fn {el, j}, acc ->
        Map.put(acc, {i, j}, el)
      end)
    end)
  end

  def to_3Dmatrix(stream) do
    stream
    |> Stream.with_index
    |> Enum.reduce(%{}, fn {line, i}, acc ->
      line
      |> String.graphemes
      |> Enum.with_index
      |> Enum.reduce(acc, fn {el, j}, acc ->
        Map.put(acc, {i, j, 0}, el)
      end)
    end)
  end

  def to_4Dmatrix(stream) do
    stream
    |> Stream.with_index
    |> Enum.reduce(%{}, fn {line, i}, acc ->
      line
      |> String.graphemes
      |> Enum.with_index
      |> Enum.reduce(acc, fn {el, j}, acc ->
        Map.put(acc, {i, j, 0, 0}, el)
      end)
    end)
  end
end
