defmodule AdventOfCode.Utils.Node do
  defstruct [parents: [], children: %{}]

  def add_parent(node, parent) do
    Map.update!(node, :parents, &([parent | &1]))
  end

  def add_children(node, children) do
    Map.update!(node, :children, fn c -> Map.merge(c, children) end)
  end
end

defmodule AdventOfCode.Utils.Tree do
  alias AdventOfCode.Utils.Node

  def add_parent(tree, name, parent) do
    node = tree[name] || %Node{}

    node = Node.add_parent(node, parent)

    Map.put(tree, name, node)
  end

  def add_children(tree, name, children) do
    node = tree[name] || %Node{}

    node = Node.add_children(node, children)

    Map.put(tree, name, node)
  end
end

# red -> 1 white, 2 yellow
