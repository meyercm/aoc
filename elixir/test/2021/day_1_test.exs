defmodule Aoc.Y2021.Day1Test do
  use ExUnit.Case
  alias Aoc.Y2021.Day1

  @example "199
200
208
210
200
207
240
269
260
263
"
@example_collapsed []
  @parsed_example Day1.process_lines(@example)

  describe "process lines" do
    test "it can read the example" do
      expected = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
      assert expected == Day1.process_lines(@example)
    end
  end

  describe "part_1" do
    test "gets the right answer" do
      assert 1722 == Day1.part_1()
    end
  end

  describe "do_part_1" do
    test "computes the correct answer from the example" do
      assert 7 == Day1.do_part_1(@parsed_example)
    end
  end

  describe "compare" do
    test "it handles some examples correctly" do
      assert Day1.compare({200, 199}) == :dec
      assert Day1.compare({200, 210}) == :inc
      assert Day1.compare({200, 200}) == :eql
    end
  end

  describe "part 2" do
    test "gets the right answer" do
      assert Day1.part_2() == 1748
    end
  end

end
