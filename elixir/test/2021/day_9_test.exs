defmodule Aoc.Y2021.Day9Test do
  use ExUnit.Case
  alias Aoc.Y2021.Day9


  @example_raw "2199943210
3987894921
9856789892
8767896789
9899965678
"

  @example_parsed Day9.parse_data(@example_raw)

  test "parsed data is correct length" do
    assert Enum.count(@example_parsed) == 50
  end
  test "parsed data has proper values" do
    assert Map.get(@example_parsed, {0,0}) == 2
    assert Map.get(@example_parsed, {1,2}) == 8
  end

  test "low_points gives the right answer" do
    result = Day9.low_points(@example_parsed)
    assert Enum.count(result) == 4
    assert Enum.member?(result, {0, 1})
    assert Enum.member?(result, {0, 9})
    assert Enum.member?(result, {2, 2})
    assert Enum.member?(result, {4, 6})
  end

  test "part 1 is correct" do
    assert Day9.part_1() == 417
  end

  test "height returns 9 for soemthing off the map" do
    assert Day9.height({-1, -1}, @example_parsed) == 9
  end

  test "adjacent points gives back 4 points" do
    assert Enum.member?(Day9.adjacent_points({1,1}), {0, 1})
    assert Enum.member?(Day9.adjacent_points({1,1}), {2, 1})
    assert Enum.member?(Day9.adjacent_points({1,1}), {1, 0})
    assert Enum.member?(Day9.adjacent_points({1,1}), {1, 2})
  end

  test "grow_basin matches the example" do
    assert 3 == Day9.grow_basin({0,1}, @example_parsed) |> Day9.basin_size()
    assert 9 == Day9.grow_basin({0,9}, @example_parsed) |> Day9.basin_size()
    assert 14 == Day9.grow_basin({2,2}, @example_parsed) |> Day9.basin_size()
    assert 9 == Day9.grow_basin({4,6}, @example_parsed) |> Day9.basin_size()
  end

  test "part 2 is correct" do
    assert Day9.part_2() == 1148965
  end

  test "do_part_2 matches example" do
    assert 1134 == Day9.do_part_2(@example_parsed)
  end
end
