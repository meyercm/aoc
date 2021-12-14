defmodule Aoc.Y2021.Day11Test do
  use ExUnit.Case
  alias Aoc.Y2021.Day11
  import PredicateSigil

  @example_raw "5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"

  @example_1 "6594254334
3856965822
6375667284
7252447257
7468496589
5278635756
3287952832
7993992245
5957959665
6394862637"

  @example_2 "8807476555
5089087054
8597889608
8485769600
8700908800
6600088989
6800005943
0000007456
9000000876
8700006848"

  @example_3 "0050900866
8500800575
9900000039
9700000041
9935080063
7712300000
7911250009
2211130000
0421125000
0021119000"
  @example_parsed Day11.parse_data(@example_raw)

  test "parse_data loads all the items" do
    assert 100 = map_size(@example_parsed.items)
  end

  test "example points match" do
    assert Day11.do_part_1(@example_parsed) == 1656
  end

  test "part 1 gets the right answer" do
    assert Day11.part_1() == 1755
  end

  test "part 2 matches example" do
    assert Day11.do_part_2(@example_parsed, 1) == 195
  end

  test "part 2 gets correct answer" do
    assert Day11.part_2() == 0
  end

  test "one step matches example" do
    result = Day11.step(@example_parsed)
    assert result.items == Day11.parse_data(@example_1).items
  end

  test "two steps matches example" do
    result = Day11.step(@example_parsed) |> Day11.step()
    assert result.items == Day11.parse_data(@example_2).items

  end
end
