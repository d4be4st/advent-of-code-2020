defmodule AdventOfCode.Utils.HashList do
  defstruct list: %{}, count: 0

  def add(hash_list, element, index) do
    hash_list
    |> Map.update!(:list, fn l -> Map.put(l, index, element) end )
    |> Map.update!(:count, &(&1 + 1))
  end

  def get(hash_list, index) do
    hash_list.list[index]
  end
end
