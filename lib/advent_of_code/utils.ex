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
end
