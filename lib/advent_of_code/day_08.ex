defmodule AdventOfCode.Day08 do
  alias AdventOfCode.Utils
  alias AdventOfCode.Utils.Console

  def part1(args) do
    {:halt, console} =
      args
      |> Utils.parse_input()
      |> Console.parse_instructions()
      |> run_until_halt

    console.accumulator
  end

  def part2(args) do
    {:stop, console} = 
      args
      |> Utils.parse_input()
      |> Console.parse_instructions()
      |> modify_until_stop(0)

    console.accumulator
  end

  def run_until_halt(console) do
    case Console.run_instruction(console) do
      {:ok, console} -> run_until_halt(console)
      {status, console} -> {status, console}
    end
  end

  def modify_until_stop(console, changed_address) do
    {status, new_console} = 
      case Console.modify_operation(console, changed_address) do
        {:ok, new_console} -> 
          run_until_halt(new_console)
        {:skip, new_console} -> 
          modify_until_stop(new_console, changed_address + 1)
      end

    case status do
      :halt -> modify_until_stop(console, changed_address + 1)
      :stop -> {:stop, new_console}
    end
  end
end
