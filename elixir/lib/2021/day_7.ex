defmodule Aoc.Y2021.Day7 do
  import ShorterMaps
  import PredicateSigil

  def load_data() do
    File.read!("../data/2021/day_7.txt")
    |> parse_data()
  end

  def parse_data(raw) do
    String.trim(raw)
    |> String.split(",")
    |> Enum.reject(~p(""))
    |> Enum.map(&String.to_integer/1)
  end

  def move_cost_2(from, to) do
    linear = abs(from - to)
    linear * (linear + 1) / 2
  end

  def part_2() do
    positions = load_data()
    {min, max} = Enum.min_max(positions)
    for target <- min..max do
      Stream.map(positions, fn p -> move_cost_2(p, target) end)
      |> Enum.sum()
    end
    |> Enum.min
  end

end
