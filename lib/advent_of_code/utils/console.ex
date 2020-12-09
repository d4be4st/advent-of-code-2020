defmodule AdventOfCode.Utils.Console do
  use StructAccess
  defstruct address: 0,
            accumulator: 0,
            visited_addresses: MapSet.new(),
            instructions: %{},
            number_of_instructions: 0

  alias AdventOfCode.Utils.Console

  def new() do
    %Console{}
  end

  def parse_instructions(lines) do
    instructions =
      lines
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, index}, instructions ->
        Map.put(instructions, index, parse_instruction(line))
      end)

    %Console{instructions: instructions, number_of_instructions: Enum.count(instructions)}
  end

  def parse_instruction(line) do
    captures = Regex.named_captures(~r/(?<operation>\w{3}) (?<argument>[+-]\d+)/, line)
    %{operation: captures["operation"], argument: String.to_integer(captures["argument"])}
  end

  def run_instruction(console) do
    cond do
      MapSet.member?(console.visited_addresses, console.address) ->
        {:halt, console}

      console.address >= console.number_of_instructions ->
        {:stop, console}

      true ->
        new_instruction = console.instructions[console.address]

        console =
          console
          |> visit_address(console.address)
          |> run_operation(new_instruction.operation, new_instruction.argument)

        {:ok, console}
    end
  end

  def visit_address(console, address) do
    %{console | visited_addresses: MapSet.put(console.visited_addresses, address)}
  end

  def run_operation(console, operation, argument) do
    case operation do
      "acc" -> accumulate(console, argument)
      "jmp" -> jump(console, argument)
      "nop" -> noop(console)
    end
  end

  def accumulate(console, argument) do
    console
    |> Map.update!(:accumulator, &(&1 + argument))
    |> Map.update!(:address, &(&1 + 1))
  end

  def jump(console, argument) do
    console
    |> Map.update!(:address, &(&1 + argument))
  end

  def noop(console) do
    console
    |> Map.update!(:address, &(&1 + 1))
  end

  def modify_operation(console, changed_address) do
    case console.instructions[changed_address].operation do
      "nop" ->
        {:ok, put_in(console, [:instructions, changed_address, :operation], "jmp")}

      "jmp" ->
        {:ok, put_in(console, [:instructions, changed_address, :operation], "nop")}

      _ ->
        {:skip, console}
    end
  end
end
