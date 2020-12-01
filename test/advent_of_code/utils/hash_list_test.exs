defmodule AdventOfCode.Utils.HashListTest do
  use ExUnit.Case

  alias AdventOfCode.Utils.HashList

  test "new" do
    result = %HashList{}

    assert result == %HashList{list: %{}, count: 0}
  end

  test "add" do
    result = 
      %HashList{}
      |> HashList.add("helo", 0)

    assert result == %HashList{list: %{0 => "helo"}, count: 1 }
  end
end
