defmodule Aoc.Y2022.Day6Test do
  use ExUnit.Case
  alias Aoc.Y2022.Day6

  import ShorterMaps

  @examples [
    "mjqjpqmgbljsphdztnvjfqwrcgsmlb",
    "bvwbjplbgvbhsrlpgdmjqwftvncz",
    "nppdvjthqldpwncqszvftbrmjlhg",
    "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
    "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw",
  ]

  @answers_1 [7, 5, 6, 10, 11]
  @answers_2 [19, 23, 23, 29, 26]

  setup do
    examples = Enum.map(@examples, &Day6.load_string/1)
    {:ok, ~M{examples}}
  end

  test "it can load the example stacks", ~M{examples} do
    assert hd(hd(examples)) == "m"
  end

  test "can do the example for part 1", ~M{examples} do
    for {example, answer} <- Enum.zip(examples, @answers_1) do
      assert Day6.part_1(example) == answer
    end
  end


  test "gets correct answer for part 1" do
    result = File.read!("../data/2022/day_6.txt")
             |> Day6.load_string()
             |> Day6.part_1()
    assert result == 1343
  end


  test "can do the example for part 2", ~M{examples} do
    for {example, answer} <- Enum.zip(examples, @answers_2) do
      assert Day6.part_2(example) == answer
    end
  end


  test "it gets the right answer for part_2 real" do
    result = File.read!("../data/2022/day_6.txt")
    |> Day6.load_string()
    |> Day6.part_2()
    assert result == 2193
  end

end
