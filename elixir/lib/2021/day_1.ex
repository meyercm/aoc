defmodule Aoc.Y2021.Day1 do
  import PredicateSigil

  def part_1() do
    load_data()
    |> do_part_1()
  end

  def part_2() do
    load_data()
    |> do_part_2()
  end


  @spec do_part_1(list[integer()]) :: integer()
  def do_part_1(data) do
    data
    |> Enum.drop(1)
    |> Enum.zip(data)
    |> Enum.map(&reverse_tuple/1)
    |> Enum.map(&compare/1)
    |> Enum.filter(~p(:inc))
    |> Enum.count()
  end

  @spec do_part_2(list[integer()]) :: integer()
  def do_part_2(data) do
    0
  end


  @spec load_data :: list[integer()]
  def load_data() do
    File.read!("../data/2021/day_1.txt")
    |> process_lines()
  end

  def process_lines(raw) do
    raw
    |> String.split("\n")
    |> Enum.reject(~p(""))
    |> Enum.map(&String.to_integer/1)
  end

  # this lets us write a clean pipeline in do_part_1
  @spec reverse_tuple({any, any}) :: {any, any}
  def reverse_tuple({a, b}), do: {b, a}

  @type change :: :inc | :dec | :eql
  @spec compare({integer(), integer()}) :: change()
  def compare({a, b}) when a < b, do: :inc
  def compare({a, b}) when a > b, do: :dec
  def compare(_), do: :eql


end
