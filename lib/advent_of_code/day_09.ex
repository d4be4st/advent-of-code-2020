defmodule AdventOfCode.Day09 do
  alias AdventOfCode.Utils
  alias AdventOfCode.Utils.HashList

  def part1({file, preamble_number}) do
    file
    |> Utils.parse_input
    |> Stream.map(&String.to_integer/1)
    |> Utils.to_hash_list
    |> find_nonmatching_number(0, preamble_number)
  end

  def part2({file, target_sum}) do
    file
    |> Utils.parse_input
    |> Stream.map(&String.to_integer/1)
    |> Utils.to_hash_list
    |> find_contiguous(0, target_sum)
  end

  # part 1
  def find_nonmatching_number(list, min, current) do
    if list.count == current do
      :stop
    else
      case check_preamble_numbers(list, min, current) do
        {:next, number} ->  number
        {:match, _number} -> find_nonmatching_number(list, min + 1, current + 1)
      end
    end
  end

  def check_preamble_numbers(list, min, max) do
    number_to_check = HashList.get(list, max)

    check_preamble_pair(list, min, min, max, number_to_check)
  end

  def check_preamble_pair(list, i, j, max, number_to_check) do
    case check_number(list, i, j, number_to_check) do
      :next -> 
        {i, j} = if j + 1 == max, do: { i + 1, i + 2 }, else: {i, j + 1}
        if i + 1 == max do
          {:next, number_to_check}
        else
          check_preamble_pair(list, i, j, max, number_to_check)
        end
      :match -> {:match, number_to_check}
    end
  end

  def check_number(list, i, j, number_to_check) do
    cond do
      HashList.get(list, i) == HashList.get(list, j) -> :next
      HashList.get(list, i) + HashList.get(list, j) == number_to_check -> :match
      true -> :next
    end
  end

  # part 2
  def find_contiguous(list, start_index, target_sum) do
    if list.count == start_index do
      :stop
    else
      case sum_contiguous(list, start_index, 0, target_sum) do
        {:match, index} -> find_min_max(list, start_index, index)
        :next -> find_contiguous(list, start_index + 1, target_sum)
      end
    end
  end

  # def find_contiguous_from_index(list, start_index, target_sum) do
  #   case sum_contiguous(list, start_index, 0, target_sum) do
  #     {:match, index} -> {:match, start_index, index}
  #     :next -> find_contiguous_from_index(list, start_index + 1, target_sum)
  #   end
  # end

  def sum_contiguous(list, index, sum, target_sum) do
    sum = sum + HashList.get(list, index)
    cond do
      sum == target_sum -> {:match, index}
      sum < target_sum -> sum_contiguous(list, index + 1, sum, target_sum)
      sum > target_sum -> :next
    end
  end

  def find_min_max(list, min, max) do
    found_list = for i <- min..max, do: HashList.get(list, i)
    min = Enum.min(found_list)
    max = Enum.max(found_list)
    min + max
  end
end
