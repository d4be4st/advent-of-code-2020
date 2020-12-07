defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Day07

  alias AdventOfCode.Utils.Node

  test "part1" do
    input = "test/support/input07.txt"
    result = part1(input)

    assert result == 4
  end

  test "part2" do
    input = "test/support/input071.txt"
    result = part2(input)

    assert result == 32
  end

  test "part21" do
    input = "test/support/input072.txt"
    result = part2(input)

    assert result == 126
  end

  test "add to tree" do
    input = %{
      "name" => "shiny lime",
      "children" => %{"muted magenta" => "3", "clear cyan" => "1"}
    }

    assert add_to_tree(input, %{}) == %{
             "clear cyan" => %Node{children: %{}, parents: ["shiny lime"]},
             "muted magenta" => %Node{children: %{}, parents: ["shiny lime"]},
             "shiny lime" => %Node{
               children: %{"clear cyan" => "1", "muted magenta" => "3"},
               parents: []
             }
           }
  end

  test "parse line" do
    input = "shiny lime bags contain 3 muted magenta bags, 3 clear cyan bags."

    assert parse_line(input) == %{
             "name" => "shiny lime",
             "children" => %{"muted magenta" => "3", "clear cyan" => "3"}
           }
  end

  test "parse children bags" do
    input = "3 muted magenta bags, 1 clear cyan bag "

    assert parse_children(input) == %{"muted magenta" => "3", "clear cyan" => "1"}
  end
end
