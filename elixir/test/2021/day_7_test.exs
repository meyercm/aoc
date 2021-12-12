defmodule Aoc.Y2021.Day7Test do
  use ExUnit.Case
  alias Aoc.Y2021.Day7

  @example_raw "16,1,2,0,4,2,7,1,2,14"
  @example_parsed Day7.parse_data(@example_raw)

  test "parse_data can parse the example" do
    assert 10 == length(@example_parsed)
    assert 16 == hd(@example_parsed)
  end

  test "move_cost 2 matches examples" do
    assert Day7.move_cost_2(16, 5) == 66
    assert Day7.move_cost_2(1, 5) == 10
  end


  # test "part 2 gives correct answer" do
  #   assert Day7.part_2 == 94017638
  # end
end
