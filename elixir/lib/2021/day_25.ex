defmodule Aoc.Y2021.Day25 do
  import ShorterMaps
  import PredicateSigil

  defmodule State do
    defstruct [
      points: %{},
      rows: 0,
      cols: 0,
      steps: 0,
    ]
  end

  def load_data() do
    File.read!("../data/2021/day_25.txt")
    |> parse_data()
  end

  def parse_data(raw) do
    lines = String.split(raw, "\n")
    |> Enum.reject(~p(""))
    points = lines
    |> Enum.with_index()
    |> Enum.map(fn {l, row} ->
      String.codepoints(l)
      |> Enum.with_index()
      |> Enum.map(fn {c, col} -> {{row, col}, parse_char(c)} end)
      |> Enum.reject(~p({_,nil}))
    end)
    |> List.flatten()
    |> Map.new()

    rows = Enum.count(lines)
    cols = hd(lines) |> String.length()
    ~M{%State points, rows, cols}
  end

  def parse_char("."), do: nil
  def parse_char(">"), do: ">"
  def parse_char("v"), do: "v"

  def step(~M{%State points, rows, cols, steps} = state) do
    updated = points
    |> move_right(cols)
    |> move_down(rows)
    %State{state|points: updated, steps: steps+1}
  end

  def move_right(points, cols) do
    points
    |> Enum.filter(~p({_, ">"}))
    |> Enum.reduce(points, fn {{r, c}, ">"}, acc ->
      next = {r, rem(c+1, cols)}
      case points[next] do
        nil -> acc
               |> Map.delete({r, c})
               |> Map.put(next, ">")
          _ -> acc

      end
    end)
  end

  def move_down(points, rows) do
    points
    |> Enum.filter(~p({_, "v"}))
    |> Enum.reduce(points, fn {{r, c}, "v"}, acc ->
      next = {rem(r+1, rows), c}
      case points[next] do
        nil -> acc
               |> Map.delete({r, c})
               |> Map.put(next, "v")
          _ -> acc

      end
    end)
  end

  def to_string(~M{rows, cols, points}) do
    Enum.map(0..rows-1, fn r ->
      Enum.map(0..cols-1, fn c ->
        Map.get(points, {r, c}, ".")
      end)
      |> Enum.join("")
    end)
    |> Enum.join("\n")
  end

  def part_1() do
    load_data()
    |> do_part_1()
  end

  def do_part_1(~M{points} = data) do
    next = step(data)
    if next.points == points, do: next.steps, else: do_part_1(next)
  end

  def part_2() do
    load_data()
    |> do_part_2()
  end

  def do_part_2(data) do
  end

end
