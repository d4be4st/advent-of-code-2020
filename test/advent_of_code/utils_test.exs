defmodule AdventOfCode.UtilsTest do
  use ExUnit.Case

  alias AdventOfCode.Utils
  alias AdventOfCode.Utils.HashList

  test "to_hash_list" do
    result = 
      "test/support/hash_list.txt"
      |> Utils.parse_input
      |> Utils.to_hash_list

    assert result == %HashList{list: %{ 0 => "helo", 1 => "buja" }, count: 2}
  end
end
