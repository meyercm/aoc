defmodule Aoc.Y2021.Day13 do
  import ShorterMaps
  import PredicateSigil

  defmodule State do
    defstruct [
      points: %{},
      folds: [],
    ]
  end

  def load_data() do
    File.read!("../data/2021/day_13.txt")
    |> parse_data()
  end

  def parse_data(raw) do
    [raw_points, raw_folds] = String.split(raw, "\n\n")
    points = parse_points(raw_points)
    folds = parse_folds(raw_folds)
    ~M{%State points, folds}
  end

  def parse_points(raw) do
    raw
    |> String.split("\n")
    |> Enum.reject(~p(""))
    |> Enum.map(fn s ->
      [x, y] = String.split(s, ",") |> Enum.map(&String.to_integer/1)
      {{x, y}, 1}
    end)
    |> Map.new()
  end

  def parse_folds(raw) do
    raw
    |> String.split("\n")
    |> Enum.reject(~p(""))
    |> Enum.map(fn s ->
      g = Regex.named_captures(~r/fold along (?<axis>[xy])=(?<value>\d+)/, s)
      {String.to_atom(g["axis"]), String.to_integer(g["value"])}
    end)
  end

  def fold(%State{points: initial, folds: [fold|others]}) do
    result = do_fold(initial, fold)
    %State{points: result, folds: others}
  end

  def fold_all(%State{points: points, folds: []}), do: points
  def fold_all(state) do
    fold(state)
    |> fold_all()
  end

  def do_fold(points, {:x, fold}) do
    Enum.reduce(points, points, fn pt, acc ->
      case pt do
        {{x, _y}, _count} when x < fold -> acc
        {{x, y}, count} ->
          new_coord = fold - (x - fold)
          folded = {new_coord, y}
          Map.update(acc, folded, count, fn v -> v + count end)
          |> Map.delete({x, y})
      end
    end)
  end
  def do_fold(points, {:y, fold}) do
    Enum.reduce(points, points, fn pt, acc ->
      case pt do
        {{_x, y}, _count} when y < fold -> acc
        {{x, y}, count} ->
          new_coord = fold - (y - fold)
          folded = {x, new_coord}
          Map.update(acc, folded, count, fn v -> v + count end)
          |> Map.delete({x, y})
      end
    end)
  end

  def print(points) do
    right = Map.keys(points) |> Enum.map(&(elem(&1, 0))) |> Enum.max()
    bottom = Map.keys(points) |> Enum.map(&(elem(&1, 1))) |> Enum.max()

    for y <- 0..bottom do
      for x <- 0..right do
        case Map.get(points, {x, y}) do
          nil -> "."
          _i -> "#"
        end
      end
      |> Enum.join("")
    end
    |> Enum.join("\n")
  end

  def part_1() do
    load_data()
    |> do_part_1()
  end

  def do_part_1(data) do
    fold(data)
    |> Map.get(:points)
    |> Enum.count()
  end

  def part_2() do
    load_data()
    |> do_part_2()
  end

  def do_part_2(data) do
    fold_all(data)
    |> print()
  end

end
