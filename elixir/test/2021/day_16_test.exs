defmodule Aoc.Y2021.Day16Test do
  use ExUnit.Case
  alias Aoc.Y2021.{Day16, Day16.Packet}
  import PredicateSigil

  #@example_raw "8A004A801A8002F478"
  #@example_parsed Day16.parse_data(@example_raw)

  @ex_1 "D2FE28"

  test "ex1 parses correctly" do
    {result, _rem} = Day16.parse_data(@ex_1)
    assert result.version == 6
    assert result.type == :literal
    assert result.value == 2021
  end

  test "part 1 matches example" do
    #assert Day16.do_part_1(@example_parsed) == 16
  end

  test "part 1 gets correct answer" do
    #assert Day16.part_1() == 2360
  end

  test "part 2 matches example" do
    #assert Day14.do_part_2(@example_parsed) == 2188189693529
  end

  test "part 2 gets correct answer" do
    #assert Day14.part_2() == 0
  end

end
