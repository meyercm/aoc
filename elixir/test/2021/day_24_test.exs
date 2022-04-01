defmodule Aoc.Y2021.Day24Test do
  use ExUnit.Case
  alias Aoc.Y2021.Day24
  alias Aoc.Y2021.Day24.ALU
  import PredicateSigil

  @ex_raw ""

  @ex Day24.parse_data(@ex_raw)

  @negate Day24.parse_data("inp x
mul x -1
")
  @three_x Day24.parse_data("inp z
inp x
mul z 3
eql z x")
  @binary Day24.parse_data("inp w
add z w
mod z 2
div w 2
add y w
mod y 2
div w 2
add x w
mod x 2
div w 2
mod w 2")

@convoluted Day24.parse_data("inp w
inp y
add z 5
mul z 2
add z 3
eql y z
add x y
eql w x")

  test "collapse convoluted" do
    assert "0" == ALU.symbolic_collapse(@convoluted) |> Map.get(:w)|> ALU.simplify |> ALU.stringify()
  end

  test "simplify identities" do
    assert :input_1 == ALU.simplify({:add, 0, :input_1})
    assert :input_1 == ALU.simplify({:add, :input_1, 0})
    assert :input_1 == ALU.simplify({:mul, 1, :input_1})
    assert :input_1 == ALU.simplify({:mul, :input_1, 1})
    assert 0 == ALU.simplify({:mul, 0, :input_1})
    assert 0 == ALU.simplify({:mul, :input_1, 0})
    assert :input_1 == ALU.simplify({:div, :input_1, 1})
    assert 0 == ALU.simplify({:div, 0, :input_1})
    assert 1 == ALU.simplify({:div, :input_1, :input_1})
    assert :input_1 == ALU.simplify({:mod, :input_1, 1})
    assert 0 == ALU.simplify({:mod, :input_1, :input_1})
    assert 1 == ALU.simplify({:eql, :input_1, :input_1})
  end

  test "simplify equals" do
    "(input_0+1)%26)+13)==input_1)"
    assert 0 == ALU.simplify({:eql, {:add, {:mod, {:add, :input_0, 1},26}, 13}, :input_1})
  end

  test "negate example" do
    assert [{:inp, :x}, {:mul, :x, -1}] == @negate
    result =
      ALU.new([1])
      |> ALU.run(@negate)
      |> Map.get(:x)
    assert result == -1
  end

  test "collapse negate" do
    result = @negate |> ALU.symbolic_collapse()
    assert result.x == {:mul, :input_0, -1}
  end

  test "three x example" do
    assert length(@three_x) == 4
    assert ALU.new([1, 3]) |> ALU.run(@three_x) |> Map.get(:z) == 1
    assert ALU.new([1, 4]) |> ALU.run(@three_x) |> Map.get(:z) == 0
  end

  test "collapse three x" do
    result = @three_x |> ALU.symbolic_collapse()
    assert result.z == {:eql, {:mul, :input_0, 3}, :input_1}
  end

  test "binary example" do
    result = ALU.new([5]) |> ALU.run(@binary)
    assert result.w == 0
    assert result.x == 1
    assert result.y == 0
    assert result.z == 1
  end

  @validator Day24.load_data()
  test "part 1 partial input" do
    result = ALU.new([1, 1]) |> ALU.run_thru(@validator)
    # assert result == []
  end


  test "part 1 brute force" do
    assert Day24.part_1() == 0
  end

  # test "part 2 matches example" do
  #   assert Day24.do_part_2(@ex_2) == 0
  # end

  # test "part 2 gets correct answer" do
  #   assert Day24.part_2() == 0
  # end

end
