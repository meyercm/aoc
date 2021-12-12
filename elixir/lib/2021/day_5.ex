defmodule Aoc.Y2021.Day5 do
  import ShorterMaps
  import PredicateSigil

  defmodule Data do
    defstruct [
      lines: []
    ]
  end


  defmodule Point do
    defstruct [
      x: nil,
      y: nil,
    ]
    def parse(raw) do
      [x, y] = String.split(raw, ",")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)
      ~M{%Point x, y}
    end
  end

  defmodule Line do
    defstruct [
      start: nil,
      stop: nil,
    ]

    def parse(raw) do
      [start, stop] = String.split(raw, "->")
      |> Enum.map(&Point.parse/1)
      ~M{%Line start, stop}
    end

    def is_horizontal_or_vertical(%Line{start: ~M{x}, stop: ~M{x}}), do: true
    def is_horizontal_or_vertical(%Line{start: ~M{y}, stop: ~M{y}}), do: true
    def is_horizontal_or_vertical(_), do: false
  end

  def part_1() do
    load_data().lines
    |> Enum.filter(&Line.is_horizontal_or_vertical/1)
    |> generate_coverage()
    |> Enum.frequencies()
    |> Enum.filter(fn {_p, f} -> f > 1 end)
    |> Enum.count
  end

  def part_2() do
    load_data().lines
    |> generate_coverage()
    |> Enum.frequencies()
    |> Enum.filter(fn {_p, f} -> f > 1 end)
    |> Enum.count
  end


  @spec load_data :: %Aoc.Y2021.Day5.Data{lines: list}
  def load_data() do
    File.read!("../data/2021/day_5.txt")
    |> parse_data()
  end

  def parse_data(raw) do
    lines = raw
    |> String.split("\n")
    |> Enum.reject(~p(""))
    |> Enum.map(&Line.parse/1)
    %Data{lines: lines}
  end

  def generate_coverage(lines) do
    Enum.map(lines, fn ~M{start, stop} ->
      generate_line(start, stop)
    end)
    |> List.flatten()
  end

  def generate_line(%{x: x, y: y1}, %{x: x, y: y2}) do
    for y <- y1..y2, do: ~M{%Point x, y}
  end
  def generate_line(%{x: x1, y: y}, %{x: x2, y: y}) do
    for x <- x1..x2, do: ~M{%Point x, y}
  end
  def generate_line(%{x: x1, y: y1}, %{x: x2, y: y2}) do
    Enum.zip(x1..x2, y1..y2)
    |> Enum.map(fn {x, y} -> ~M{%Point x, y} end)
  end
end
