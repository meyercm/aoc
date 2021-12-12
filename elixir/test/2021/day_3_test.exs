defmodule Aoc.Y2021.Day3Test do
  use ExUnit.Case
  alias Aoc.Y2021.Day3

  @example "
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
  "

  describe "part 1" do
    test "it gets the right answer" do
      assert Day3.part_1() == 3148794
    end
  end

  describe "part 2" do
    test "it gets the right answer" do
      assert Day3.part_2 == 2795310
    end
  end

  describe "load_data" do
    test "it gives the expected number of results" do
      assert length(Day3.load_data) == 1000
    end
  end

  describe "process_lines" do
    test "it can read the example" do
      result = Day3.process_lines(@example)
      assert length(result) == 12
    end
  end

  describe "load_line" do
    test "it constructs record appropriately" do
      result = Day3.load_line("00100")
      assert result == %Day3.Record{raw: "00100", decimal: 4, digits: [0,0,1,0,0]}
    end
  end

  describe "gamma_rate" do
    test "it gets the answer for the example" do
      data = Day3.process_lines(@example)
      assert Day3.gamma_rate(data) == 0b10110
    end
  end

  describe "epsilon_rate" do
    test "it gets the answer for the example" do
      data = Day3.process_lines(@example)
      assert Day3.epsilon_rate(data) == 9
    end
  end

  describe "add_list" do
    test "simple example works" do
      result = Day3.add_list([1,2], [3, 7])
      assert result == [4, 9]
    end
  end

  describe "most_common" do
    test "it gets the right answers for the example" do
      result = Day3.most_common(Day3.process_lines(@example), 0)
      assert result == 1
    end
  end

  describe "oxygen_gen" do
    test "it gets the result from the example" do
      result = Day3.oxygen_gen(Day3.process_lines(@example))
      assert result == 23
    end
  end

  describe "co2_scrub" do
    test "it gets the result from the example" do
      result = Day3.co2_scrub(Day3.process_lines(@example))
      assert result == 10
    end
  end



end
