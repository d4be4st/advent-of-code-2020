defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  alias AdventOfCode.Utils.Node

  test "Node add_parent" do
    node = %Node{}

    assert Node.add_parent(node, "red") == %Node{parents: ["red"]}
  end

  test "Node add_children" do
    node = %Node{children: %{"blue" => 2}}

    assert Node.add_children(node, %{"red" => 1}) == %Node{children: %{"red" => 1, "blue" => 2}}
  end
end
