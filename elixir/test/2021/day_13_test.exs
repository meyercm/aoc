defmodule Aoc.Y2021.Day13Test do
  use ExUnit.Case
  alias Aoc.Y2021.Day13
  import PredicateSigil

  @example_raw "6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5
"

  @example_parsed Day13.parse_data(@example_raw)
  @expected_2 "\
#####
#...#
#...#
#...#
#####"

@expected_final "\
####.#..#...##.#..#..##..####.#..#.###.
...#.#..#....#.#..#.#..#.#....#..#.#..#
..#..#..#....#.#..#.#..#.###..####.#..#
.#...#..#....#.#..#.####.#....#..#.###.
#....#..#.#..#.#..#.#..#.#....#..#.#...
####..##...##...##..#..#.#....#..#.#..."
  test "parse loads data correctly" do
    assert 18 == @example_parsed.points |> Enum.count()
    assert 1 == @example_parsed.points[{0, 14}]
    assert 2 == @example_parsed.folds |> Enum.count()
    assert {:y, 7} == @example_parsed.folds |> Enum.at(0)
    assert {:x, 5} == @example_parsed.folds |> Enum.at(1)
  end

  test "fold_all works for the example" do
    result = Day13.fold_all(@example_parsed)
    assert result[{0,0}] != nil
    assert result[{0,1}] != nil
    assert result[{0,2}] != nil
    assert result[{0,3}] != nil
    assert result[{0,4}] != nil
    assert result[{1,0}] != nil
    assert result[{1,4}] != nil
    assert result[{2,0}] != nil
    assert result[{2,4}] != nil
    assert result[{3,0}] != nil
    assert result[{3,4}] != nil
    assert result[{4,0}] != nil
    assert result[{4,1}] != nil
    assert result[{4,2}] != nil
    assert result[{4,3}] != nil
    assert result[{4,4}] != nil
    assert Enum.count(result) == 16
  end


  test "part 1 matches example" do
    assert Day13.do_part_1(@example_parsed) == 17
  end

  test "part 1 gets correct answer" do
    assert Day13.part_1() == 737
  end

  test "part 2 matches example" do
    assert @expected_2 == Day13.do_part_2(@example_parsed)
  end

  test "part 2 gets correct answer" do
    assert @expected_final == Day13.part_2()
  end
end
