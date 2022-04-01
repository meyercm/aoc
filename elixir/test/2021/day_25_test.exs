defmodule Aoc.Y2021.Day25Test do
  use ExUnit.Case
  alias Aoc.Y2021.Day25
  import PredicateSigil

  @ex_raw "v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>
"

  @ex Day25.parse_data(@ex_raw)

  test "parse check" do
    data = Day25.parse_data("...>>>>>...")
    assert 1 == data.rows
    assert 11 == data.cols

  end

  test "move_right example" do
    data = Day25.parse_data("...>>>>>..>") |> Day25.step()
    assert Day25.to_string(data) == ">..>>>>.>.."
  end

  test "move_down example" do
    data = Day25.parse_data(".v\n.v\nv.") |> Day25.step()
    assert Day25.to_string(data) == "vv\n..\n.v"
  end

  test "part 1 matches example" do
    assert Day25.do_part_1(@ex) == 58
  end


  test "part 1 gets correct answer" do
    assert Day25.part_1() == 0
  end

  test "part 2 matches example" do
    # assert Day22.do_part_2(@ex_2) == 2758514936282235
  end

  test "part 2 gets correct answer" do
    # assert Day22.part_2() == 0
  end

end
