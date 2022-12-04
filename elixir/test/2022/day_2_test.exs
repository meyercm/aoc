defmodule Aoc.Y2022.Day2Test do
  use ExUnit.Case
  alias Aoc.Y2022.Day2

  import ShorterMaps

  @example ~S"A Y
B X
C Z"

  setup do
    strategy = Day2.load_string_1(@example)
    strategy_2 = Day2.load_string_2(@example)
    {:ok, ~M{strategy, strategy_2}}
  end

  test "it can load the example", ~M{strategy, strategy_2} do
    assert length(strategy) == 3
    assert Enum.at(strategy, 0) == [:rock, :paper]
    assert length(strategy_2) == 3
    assert Enum.at(strategy_2, 0) == [:rock, :rock]
  end

  test "example scores correct", ~M{strategy, strategy_2} do
    [r1, r2, r3] = strategy
    assert 8 == Day2.score_round(r1)
    assert 1 == Day2.score_round(r2)
    assert 6 == Day2.score_round(r3)

    [r1, r2, r3] = strategy_2
    assert 4 == Day2.score_round(r1)
    assert 1 == Day2.score_round(r2)
    assert 7 == Day2.score_round(r3)
  end

  test "scores example correctly", ~M{strategy, strategy_2} do
    assert Day2.part_1(strategy) == 15
    assert Day2.part_1(strategy_2) == 12
  end

  test "gets correct answer for part 1" do
    result = File.read!("../data/2022/day_2.txt")
    |> Day2.load_string_1()
    |> Day2.part_1()
    assert result == 15572
  end

  test "gets correct answer for part 2" do
    result = File.read!("../data/2022/day_2.txt")
    |> Day2.load_string_2()
    |> Day2.part_1()
    assert result == 16098
  end


end
