defmodule Mix.Tasks.D16.P2 do
  use Mix.Task

  import AdventOfCode.Day16

  @shortdoc "Day 16 Part 2"
  def run(args) do
    input = {"inputs/input16_1.txt", "53,67,73,109,113,107,137,131,71,59,101,179,181,61,97,173,103,89,127,139", "inputs/input16_2.txt"}

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
