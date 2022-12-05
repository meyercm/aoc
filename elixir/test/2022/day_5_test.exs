defmodule Aoc.Y2022.Day5Test do
  use ExUnit.Case
  alias Aoc.Y2022.Day5

  import ShorterMaps

  @examples [
    "    [D]    ",
    "[N] [C]    ",
    "[Z] [M] [P]",
    " 1   2   3 ",
    "",
    "move 1 from 2 to 1",
    "move 3 from 1 to 3",
    "move 2 from 2 to 1",
    "move 1 from 1 to 2",
  ]

  @example Enum.join(@examples, "\n")


  setup do
    {stacks, directions} = Day5.load_string(@example)
    {:ok, ~M{stacks, directions}}
  end

  test "it can load the example stacks", ~M{stacks} do
    assert Enum.count(stacks) == 3
    assert stacks[1] == ["N", "Z"]
    assert stacks[2] == ["D", "C", "M"]
    assert stacks[3] == ["P"]
  end

  test "it can load the example directions", ~M{directions} do
    assert length(directions) == 4
    [first|_rest] = directions
    assert first.count == 1
    assert first.from == 2
    assert first.to == 1
  end

  test "can do one", ~M{stacks, directions} do
    [a| _rest] = directions
    result_a = Day5.apply_direction(a, stacks)
    assert result_a[1] == ["D", "N", "Z"]
    assert result_a[2] == ["C", "M"]
    assert result_a[3] == ["P"]
  end

  test "can do the example for part 1", ~M{stacks, directions} do
    result = Day5.part_1({stacks, directions})
    assert result == "CMZ"
  end


  test "gets correct answer for part 1" do
    result = File.read!("../data/2022/day_5.txt")
             |> Day5.load_string()
             |> Day5.part_1()
    assert result == "WSFTMRHPP"
  end

  test "can do a part 2 move", ~M{stacks, directions} do
    [a, b| _rest] = directions
    result_a = Day5.apply_direction_bulk(a, stacks)
    assert result_a[1] == ["D", "N", "Z"]
    assert result_a[2] == ["C", "M"]
    assert result_a[3] == ["P"]

    result_b = Day5.apply_direction_bulk(b, result_a)
    assert result_b[1] == []
    assert result_b[2] == ["C", "M"]
    assert result_b[3] == ["D", "N", "Z", "P"]
  end

  test "can do the example for part 2", ~M{stacks, directions} do
    result = Day5.part_2({stacks, directions})
    assert result == "MCD"
  end


  test "it gets the right answer for part_2 real" do
    result = File.read!("../data/2022/day_5.txt")
    |> Day5.load_string()
    |> Day5.part_2()
    assert result == "GSLCMFBRP"
  end

end
