defmodule Aoc.Y2021.Day14Test do
  use ExUnit.Case
  alias Aoc.Y2021.Day14
  import PredicateSigil

  @example_raw "NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
"
  @example_parsed Day14.parse_data(@example_raw)

  test "pairs gives correct answer" do
    result = Day14.pairs(["A", "B", "C", "D"])
    assert result == ["AB", "BC", "CD"]
  end

  test "parsed data is correct" do
    assert ["N", "N", "C", "B"] == @example_parsed.polymer
    assert 16 = map_size(@example_parsed.rules)
    assert "B" == @example_parsed.rules["NC"]
  end

  test "one expansion gives correct answer" do
    assert "NCNBCHB" == Day14.expand(@example_parsed, 1).polymer |> Enum.into("")
  end
  test "two expansionw gives correct answer" do
    assert "NBCCNBBBCBHCB" == Day14.expand(@example_parsed, 2).polymer |> Enum.into("")
  end

  test "part 1 matches example" do
    assert Day14.do_part_1(@example_parsed) == 1588
  end

  test "part 1 gets correct answer" do
    assert Day14.part_1() == 2360
  end

  test "part 2 matches example" do
    #assert Day14.do_part_2(@example_parsed) == 2188189693529
  end

  test "part 2 gets correct answer" do
    #assert Day14.part_2() == 0
  end

end
