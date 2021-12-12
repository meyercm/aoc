defmodule Aoc.Y2021.Day4Test do
  use ExUnit.Case

  alias Aoc.Y2021.{Day4, Day4.Board}
  @example_raw "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
 "
 @parsed Day4.parse_data(@example_raw)
 @seq @parsed.sequence
 @board1 Enum.at(@parsed.boards, 0)
#  @board2 Enum.at(@parsed.boards, 1)
 @board3 Enum.at(@parsed.boards, 2)

  describe "parse_data" do
    test "it can load the sequence from the example" do
      assert length(@parsed.sequence) == 27
      assert hd(@parsed.sequence) == 7
      assert hd(Enum.reverse(@parsed.sequence)) == 1
    end
    test "it can load the boards from the example" do
      assert length(@parsed.boards) == 3
      assert Board.get(@board1, 0, 0) == 22
      assert Board.get(@board1, 0, 1) == 13
      assert Board.get(@board1, 1, 0) == 8
      assert Board.get(@board1, 2, 0) == 21
    end
  end

  describe "Board.has_won" do
    test "it returns true if an entire row is checked off" do
      result = Enum.reduce([8,2,23,4,24], @board1, &(Board.check_off(&2, &1)))
      assert Board.has_won(result)
    end
    test "it returns true if an entire column is checked off" do
      result = Enum.reduce([13,2,9,10,12], @board1, &(Board.check_off(&2, &1)))
      assert Board.has_won(result)
    end
  end

  describe "Board.check_off" do
    test "it adds to the used list if the element is not present" do
      result = Board.check_off(@board1, 99)
      assert result.used == [99]
    end
    test "it makes ane element checked off" do
      result = Board.check_off(@board1, 22)
      assert Board.is_checked(result, 22)
      assert !Board.is_checked(@board1, 22)
    end
  end
  describe "Board.score" do
    test "it matches the result from the example" do
      result = Enum.reduce(@seq, @board3, &(Board.check_off(&2, &1)))
      assert hd(result.used) == 24
      assert length(result.used) == 12
      assert Board.score(result) == 4512
    end
  end

  describe "Day4.part_1" do
    test "it gets the right answer" do
      assert Day4.part_1() == 25023
    end
  end
  describe "Day4.part_2" do
    test "it gets the right answer" do
      assert Day4.part_2() == 2634
    end
  end
end
