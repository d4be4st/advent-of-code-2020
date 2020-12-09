defmodule AdventOfCode.ConsoleTest do
  use ExUnit.Case

  import AdventOfCode.Utils.Console
  alias AdventOfCode.Utils.Console

  test "parse instruction 1" do
    input = "acc +1"
    assert parse_instruction(input) == %{operation: "acc", argument: 1}
  end

  test "parse instruction 2" do
    input = "jmp -10"
    assert parse_instruction(input) == %{operation: "jmp", argument: -10}
  end

  test "parse instructions" do
    input = ["acc +2", "jmp -10"]

    assert parse_instructions(input) ==
             %Console{
               accumulator: 0,
               address: 0,
               instructions: %{
                 0 => %{argument: 2, operation: "acc"},
                 1 => %{argument: -10, operation: "jmp"}
               },
               visited_addresses: MapSet.new(),
               number_of_instructions: 2
             }
  end

  test "visit address" do
    console = new()

    assert MapSet.to_list(visit_address(console, 3).visited_addresses) == [3]
  end

  test "accumulate" do
    console = new()

    assert accumulate(console, 2) ==
             %Console{
               accumulator: 2,
               address: 1,
               instructions: %{},
               visited_addresses: MapSet.new()
             }
  end

  test "jump" do
    console = new()

    assert jump(console, 2) ==
             %Console{
               accumulator: 0,
               address: 2,
               instructions: %{},
               visited_addresses: MapSet.new()
             }
  end

  test "modify operation" do
    input = %Console{
      instructions: %{
        0 => %{argument: 2, operation: "acc"},
        1 => %{argument: -10, operation: "jmp"}
      }
    }

    {:skip, result} = modify_operation(input, 0) 
    assert result.instructions == %{
             0 => %{argument: 2, operation: "acc"},
             1 => %{argument: -10, operation: "jmp"}
           }

    {:ok, result} = modify_operation(input, 1) 
    assert result.instructions == %{
             0 => %{argument: 2, operation: "acc"},
             1 => %{argument: -10, operation: "nop"}
           }
  end
end
