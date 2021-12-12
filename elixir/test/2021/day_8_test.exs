defmodule Aoc.Y2021.Day8Test do
  use ExUnit.Case
  alias Aoc.Y2021.Day8

  @example "cdbga acbde eacdfbg adbgf gdebcf bcg decabf cg ebdgac egca | geac ceag faedcb cg"

  @decode "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
  @decode_mapping %{
    "ab" => 1,
    "abd" => 7,
    "abef" => 4,
    "acdfg" => 2,
    "abcdf" => 3,
    "bcdef" => 5,
    "abcdeg" => 0,
    "bcdefg" => 6,
    "abcdef" => 9,
    "abcdefg" => 8,
  }

  @decode_result 5353

  describe "load_data" do
    test "it gets the expected number of items" do
      result = Day8.load_data()
      assert Enum.count(result) == 200
    end
  end

  describe "map" do
    test "it can find the easy ones" do
      result = Day8.load_line(@example)
      assert result.mapping["cg"] == 1
      assert result.mapping["bcg"] == 7
      assert result.mapping["aceg"] == 4
      assert result.mapping["abcdefg"] == 8
    end
    test "it can find the hard ones" do
      result = Day8.load_line(@decode)
      assert result.mapping == @decode_mapping
    end
  end

  describe "decoded" do
    test "it gets the correct answer for the example" do
      record = Day8.load_line(@decode)
      result = Day8.decoded(record)
      assert result == @decode_result
    end
  end

  describe "common" do
    test "it returns the common part of two wirings" do
      assert Day8.common("ab", "bc") == "b"
      assert Day8.common("ab", "c") == ""
      assert Day8.common("ab", "abc") == "ab"
      assert Day8.common("adbf", "abc") == "ab"

    end
  end

  describe "part_2" do
    test "part 2 gets correct answer" do
      assert Day8.part_2() == 1096964
    end
  end

  describe "part 1" do
    test "part 1 gets correct answer" do
      assert 452 == Day8.part_1()
    end
    test "part 1 count gets correct answer for example" do
      assert 3 == Day8.part_1_count(Day8.load_line(@example))
    end
  end

  describe "load_line" do
    test "it includes the original in the raw key" do
      result = Day8.load_line(@example)
      assert result.raw == @example
    end

    test "it stores the elements of the left side normalized" do
      result = Day8.load_line(@example)
      assert Enum.count(result.left) == 10
      assert Enum.member?(result.left, "aceg")
    end

    test "it stores the elements of the right side normalized" do
      result = Day8.load_line(@example)
      assert result.right == ["aceg", "aceg", "abcdef", "cg"]
    end
  end

  describe "normalize_code" do
    test "it sorts the letters" do
      result = Day8.normalize_code("bac")
      assert result == "abc"
    end
  end
end
