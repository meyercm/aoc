defmodule Aoc.Y2022.Day4Test do
  use ExUnit.Case
  alias Aoc.Y2022.Day4

  import ShorterMaps

  @examples [
    "2-4,6-8",
    "2-3,4-5",
    "5-7,7-9",
    "2-8,3-7",
    "6-6,4-6",
    "2-6,4-8",
  ]

  @example Enum.join(@examples, "\n")


  setup do
    pairs = Day4.load_string(@example)
    {:ok, ~M{pairs}}
  end

  test "it can load the example", ~M{pairs} do
    assert length(pairs) == 6
    [first|_rest] = pairs
    assert first.elf_1 == 2..4
    assert first.elf_2 == 6..8
  end

  test "it can calculate containment for the example", ~M{pairs} do
    [a,b,c,d,e,f] = pairs
    refute Day4.completely_contained?(a)
    refute Day4.completely_contained?(b)
    refute Day4.completely_contained?(c)
    assert Day4.completely_contained?(d)
    assert Day4.completely_contained?(e)
    refute Day4.completely_contained?(f)
  end

  test "it gets the score from the xamples", ~M{pairs} do
    assert 2 == Day4.part_1(pairs)
  end

  test "gets correct answer for part 1" do
    result = File.read!("../data/2022/day_4.txt")
             |> Day4.load_string()
             |> Day4.part_1()
    assert result == 431 
  end


  test "it gets the right answer for part_2 example", ~M{pairs} do
    [a,b,c,d,e,f] = pairs
    refute Day4.partially_contained?(a)
    refute Day4.partially_contained?(b)
    assert Day4.partially_contained?(c)
    assert Day4.partially_contained?(d)
    assert Day4.partially_contained?(e)
    assert Day4.partially_contained?(f)
  end

  test "it gets the right answer for part_2 real", ~M{pairs} do
    result = File.read!("../data/2022/day_4.txt")
    |> Day4.load_string()
    |> Day4.part_2()
    assert result == 823
  end

end
