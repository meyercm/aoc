defmodule Aoc.Y2021.Day10Test do
  use ExUnit.Case
  alias Aoc.Y2021.Day10
  import PredicateSigil

  @example_raw "[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
"

  @example_parsed Day10.parse_data(@example_raw)
  @ex_1 Day10.parse_line("[({(<(())[]>[[{[]{<()<>>")

  test "parse_data gives the right sized things" do
    assert length(@example_parsed) == 10
    assert length(Enum.at(@example_parsed, 1)) == 22
  end

  test "first_error matches examples" do
    assert "]" == Day10.parse_line("(]") |> Day10.first_error()
    assert "}" == Day10.parse_line("{([(<{}[<>[]}>{[]{[(<()>") |> Day10.first_error()
  end

  test "example points match" do
    assert Day10.do_part_1(@example_parsed) == 26397
  end

  test "part 1 gets the right answer" do
    assert Day10.part_1() ==345441
  end

  test "completing sequence matches example" do
    result = Day10.completing_sequence(@ex_1)
    assert "}}]])})]" == Enum.join(result, "")
    assert 288957 == Day10.completion_points(result)
  end

  test "part 2 matches example" do
    assert Day10.do_part_2(@example_parsed) == 288957
  end

  test "part 2 gets correct answer" do
    assert Day10.part_2() == 3235371166
  end
end
