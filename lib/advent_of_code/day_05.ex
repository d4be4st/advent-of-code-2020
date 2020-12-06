defmodule AdventOfCode.Day05 do
  alias AdventOfCode.Utils

  def part1(args) do
    args
    |> Utils.parse_input()
    |> Enum.map(&seat_id/1)
    |> Enum.max
  end

  def part2(args) do
    seat_ids =
      args
      |> Utils.parse_input()
      |> Enum.map(&seat_id/1)

    possible_seat_ids =
      Enum.reduce((0..127), [], fn i, acc -> 
        Enum.reduce((0..7), [], fn j, acc2 -> 
          [i * 8 + j | acc2]
        end) ++ acc
      end)

    Enum.each(Enum.sort(possible_seat_ids -- seat_ids), fn s -> IO.inspect s end)
  end

  def seat_id(code) do
    codes = String.graphemes(code)
    {row, col} = find_seat(codes, {0, 127}, {0, 7})
    row * 8 + col
  end

  def find_seat([], {row, _}, {col, _}) do
    {row, col}
  end

  def find_seat([code | codes], {minr, maxr}, {minc, maxc}) do
    case code do
      "F" ->
        new_maxr = floor((maxr - minr) / 2)
        find_seat(codes, {minr, minr + new_maxr}, {minc, maxc})

      "B" ->
        new_minr = ceil((maxr - minr) / 2)
        find_seat(codes, {minr + new_minr, maxr}, {minc, maxc})

      "L" ->
        new_maxc = floor((maxc - minc) / 2)
        find_seat(codes, {minr, maxr}, {minc, minc + new_maxc})

      "R" ->
        new_minc = ceil((maxc - minc) / 2)
        find_seat(codes, {minr, maxr}, {minc + new_minc, maxc})
    end
  end
end
