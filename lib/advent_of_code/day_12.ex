defmodule AdventOfCode.Day12 do
  alias AdventOfCode.Utils

  @directions %{0 => {1, 0}, 1 => {0, -1}, 2 => {-1, 0}, 3 => {0, 1}}

  def part1(args) do
    args
    |> Utils.parse_input()
    |> navigate_boat
    |> manhattan_distance
  end

  def part2(args) do
    args
    |> Utils.parse_input()
    |> navigate_boat2
    |> manhattan_distance
  end

  def navigate_boat(inputs) do
    Enum.reduce(inputs, {0, {0, 0}}, fn input, state ->
      input
      |> parse
      |> command(state)
    end)
  end

  def navigate_boat2(inputs) do
    Enum.reduce(inputs, {{0, 0}, {10, 1}}, fn input, state ->
      input
      |> parse
      |> command2(state)
    end)
  end

  def parse(input) do
    op = String.first(input)
    number = String.slice(input, 1..-1) |> String.to_integer()
    {op, number}
  end

  def command(input, {direction, {x, y}}) do
    case input do
      {"N", number} ->
        {direction, {x, y + number}}

      {"S", number} ->
        {direction, {x, y - number}}

      {"E", number} ->
        {direction, {x + number, y}}

      {"W", number} ->
        {direction, {x - number, y}}

      {"R", number} ->
        new_direction = mod(direction + div(number, 90), 4)
        {new_direction, {x, y}}

      {"L", number} ->
        new_direction = mod(direction - div(number, 90), 4)
        {new_direction, {x, y}}

      {"F", number} ->
        {dx, dy} = @directions[direction]
        {direction, {x + dx * number, y + dy * number}}
    end
  end

  def command2(input, {{x, y}, {i, j}}) do
    case input do
      {"N", number} ->
        {{x, y}, {i, j + number}}

      {"S", number} ->
        {{x, y}, {i, j - number}}

      {"E", number} ->
        {{x, y}, {i + number, j}}

      {"W", number} ->
        {{x, y}, {i - number, j}}

      {"R", number} ->
        {i, j} =
          case number do
            90 -> {j, -i}
            180 -> {-i, -j}
            270 -> {-j, i}
          end
        {{x, y}, {i, j}}

      {"L", number} ->
        {i, j} =
          case number do
            90 -> {-j, i}
            180 -> {-i, -j}
            270 -> {j, -i}
          end
        {{x, y}, {i, j}}

      {"F", number} ->
        {{x + i * number, y + j * number}, {i, j}}
    end
  end

  def manhattan_distance({{x, y}, {_, _}}) do
    abs(x) + abs(y)
  end

  def manhattan_distance({_direction, {x, y}}) do
    abs(x) + abs(y)
  end

  def mod(x, y) when x > 0, do: rem(x, y)
  def mod(x, y) when x < 0, do: rem(rem(x, y) + y, y)
  def mod(0, _y), do: 0
end
