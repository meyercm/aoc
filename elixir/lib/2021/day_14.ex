defmodule Aoc.Y2021.Day14 do
  import ShorterMaps
  import PredicateSigil

  defmodule State do
    defstruct [
      polymer: [],
      rules: %{},
    ]
  end

  def load_data() do
    File.read!("../data/2021/day_14.txt")
    |> parse_data()
  end

  def parse_data(raw) do
    [poly_raw, rules_raw] = String.split(raw, "\n\n")
    %State{
      polymer: parse_polymer(poly_raw),
      rules: parse_rules(rules_raw),
    }
  end
  def parse_polymer(raw) do
    raw
    |> String.trim()
    |> String.codepoints()
  end

  def parse_rules(raw) do
    raw
    |> String.split("\n")
    |> Enum.reject(~p(""))
    |> Enum.map(fn l ->
      [k, v] = l
      |> String.split("->")
      |> Enum.map(&String.trim/1)
      {k, v}
    end)
    |> Map.new()
  end

  def expand( state, count)
  def expand(state, 0), do: state
  def expand(~M{%State polymer, rules} = state, count) do
    insertions = polymer
    |> pairs()
    |> Enum.map(fn p -> rules[p] end)

    body = Enum.zip(polymer, insertions)
    |> Enum.map(fn {l, r} -> [ l, r] end)
    |> List.flatten()

    updated = body ++ [polymer |> Enum.reverse |> hd()]

    expand(%State{state|polymer: updated}, count - 1)
  end

  def pairs(enum) do
    Enum.zip(enum, Enum.drop(enum, 1))
    |> Enum.map(fn {l, r} -> "#{l}#{r}" end)
  end

  def part_1() do
    load_data()
    |> do_part_1()
  end

  def do_part_1(data) do
    {{_, f_min}, {_, f_max}} = expand(data, 10).polymer
    |> Enum.frequencies()
    |> Enum.min_max_by(fn {_c, f} -> f end)

    f_max - f_min
  end

  def part_2() do
    load_data()
    |> do_part_2()
  end

  def do_part_2(data) do
    {{_, f_min}, {_, f_max}} = expand(data, 40).polymer
    |> Enum.frequencies()
    |> Enum.min_max_by(fn {_c, f} -> f end)

    f_max - f_min
  end
end
