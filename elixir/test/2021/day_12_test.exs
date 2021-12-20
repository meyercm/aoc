defmodule Aoc.Y2021.Day12Test do
  use ExUnit.Case
  alias Aoc.Y2021.Day12
  import PredicateSigil

  @ex_raw "start-A
start-b
A-c
A-b
b-d
A-end
b-end
"

  @ex Day12.parse_data(@ex_raw)

  test "example matches" do
    assert Enum.member?(@ex["start"], "A")
    assert Enum.member?(@ex["start"], "b")
    assert Enum.count(@ex) == 6
  end

  test "part 1 matches example" do
    assert Day12.do_part_1(@ex) == 10
  end

  test "starts upper works correctly" do
    assert Day12.starts_upper?("A")
    refute Day12.starts_upper?("a")
  end

  test "drop_paths drops one" do
    result = Day12.drop_paths(@ex, "d")
    assert result["d"] == nil
    refute Enum.member?(result["b"], "d")
    assert result["c"] == ["A"]
  end

  test "part 1 gets correct answer" do
    assert Day12.part_1() == 4338
  end

  test "part 2 matches example" do
    assert Day12.do_part_2(@ex) == 36
  end

  test "part 2 gets correct answer" do
    #assert Day14.part_2() == 0
  end

end
