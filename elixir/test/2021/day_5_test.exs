defmodule Aoc.Y2021.Day5Test do
  use ExUnit.Case
  alias Aoc.Y2021.{Day5, Day5.Point, Day5.Line}

  @example_raw "0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"

  @parsed_lines Day5.parse_data(@example_raw).lines

  describe "parse_data" do
    test "example points match" do
      assert hd(@parsed_lines).start == %Point{x: 0, y: 9}
      assert hd(@parsed_lines).stop == %Point{x: 5, y: 9}
    end
  end

  describe "generate_line" do
    test "it does the examples" do
      start = %{x: 1, y: 1}
      stop = %{x: 1, y: 3}
      result = Day5.generate_line(start, stop)
      [%{x: 1, y: 1}, %{x: 1, y: 2}, %{x: 1, y: 3}] = result
    end
    test "it does the diagonal examples" do
      start = %{x: 9, y: 7}
      stop = %{x: 7, y: 9}
      result = Day5.generate_line(start, stop)
      [%{x: 9, y: 7}, %{x: 8, y: 8}, %{x: 7, y: 9}] = result
    end
  end

  describe "isHorizontal or vertical" do
    test "horizontal" do
      assert Line.is_horizontal_or_vertical(Line.parse("1, 1 -> 1, 2"))
      assert Line.is_horizontal_or_vertical(Line.parse("2, 1 -> 1, 1"))
      refute Line.is_horizontal_or_vertical(Line.parse("2, 1 -> 1, 2"))
    end
  end

  describe "part1" do
    test "part1 gets correct answer" do
      assert Day5.part_1() == 6710
    end
    test "part2 gets correct answer" do
      assert Day5.part_2() == 20121
    end
  end
end
