defmodule Aoc.Y2022.Day3Test do
  use ExUnit.Case
  alias Aoc.Y2022.Day3

  import ShorterMaps

  @examples [
    "vJrwpWtwJgWrhcsFMMfFFhFp",
    "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
    "PmmdzqPrVvPwwTWBwg",
    "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
    "ttgJtRGJQctTZtZT",
    "CrZsJsPPZsGzwwsLwLmpwMDw",
  ]
  @example Enum.join(@examples, "\n")

  @answers ["p", "L", "P", "v", "t", "s"]

  setup do
    backpacks = Day3.load_string(@example)
    {:ok, ~M{backpacks}}
  end

  test "it can load the example", ~M{backpacks} do
    assert length(backpacks) == 6
    [first|_rest] = backpacks
    assert first.front == "vJrwpWtwJgWr"
    assert first.back == "hcsFMMfFFhFp"
  end

  test "it can find the common letter from examples", ~M{backpacks} do
    for {answer, example} <- Enum.zip(@answers, backpacks) do
      assert Day3.find_common(example) == answer
    end
  end

  test "it gets the score from the xamples", ~M{backpacks} do
    assert 157 == Day3.part_1(backpacks)
  end

  test "it can retrieve the score for one letter" do
    assert 1 = Day3.get_score("a")
    assert 27 = Day3.get_score("A")
  end

  test "gets correct answer for part 1" do
    result = File.read!("../data/2022/day_3.txt")
             |> Day3.load_string()
             |> Day3.part_1()
    assert result == 8243
  end

  test "it can find common between 3 from the examples", ~M{backpacks} do
    [a, b, c, d, e, f] = backpacks |> Enum.map(&(&1.sorted))
    assert Day3.do_common_a([a, b, c]) == "r"
    assert Day3.do_common_a([d, e, f]) == "Z"
  end

  test "it gets the right answer for part_2 example", ~M{backpacks} do
    assert Day3.part_2(backpacks) == 70
  end

  test "it gets the right answer for part_2 real", ~M{backpacks} do
    result = File.read!("../data/2022/day_3.txt")
    |> Day3.load_string()
    |> Day3.part_2()
    assert result == 2631
  end

end
