defmodule Aoc.Y2022.Day1Test do
  use ExUnit.Case
  import ShorterMaps

  alias Aoc.Y2022.Day1
  @example ~S"1000
2000
3000

4000

5000
6000

7000
8000
9000

10000"

  setup do
    elves = Day1.load_string(@example)
    {:ok, ~M{elves}}
  end

  test "it can load the example", ~M{elves} do
    assert length(elves) == 5
    assert Enum.at(elves, 0) == [1000, 2000, 3000]
  end

  test "it can find the fattest", ~M{elves} do
    assert Day1.part_1(elves) == 24000
  end

  test "it can get the right answer for part 1" do
    result = File.read!("../data/2022/day_1.txt")
    |> Day1.load_string()
    |> Day1.part_1()
    assert result == 67450
  end

  test "it can find the fattest 3", ~M{elves} do
    assert Day1.part_2(elves) == 45000
  end

  test "it can get the right answer for part 2" do
    result = File.read!("../data/2022/day_1.txt")
    |> Day1.load_string()
    |> Day1.part_2()
    assert result == 199357
  end
end
