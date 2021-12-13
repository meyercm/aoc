defmodule Aoc.Y2021.Day9 do
  import ShorterMaps
  import PredicateSigil


  def part_1() do
    map = load_data()
    map
    |> low_points()
    |> Enum.map(fn point -> height(point, map)+1 end)
    |> Enum.sum()
  end

  def part_2() do
    load_data()
    |> do_part_2()
  end
  def do_part_2(map) do
    map
    |> low_points()
    |> Enum.map(&(grow_basin(&1, map)))
    |> Enum.map(&basin_size/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.reduce(&(&1*&2))
  end

  def load_data() do
    File.read!("../data/2021/day_9.txt")
    |> parse_data()
  end

  def parse_data(raw) do
    String.split(raw, "\n")
    |> Enum.reject(~p(""))
    |> Enum.with_index()
    |> Enum.map(fn {l, row} ->
      String.codepoints(l)
      |> Enum.with_index()
      |> Enum.map(fn {raw, col} -> {{row, col}, String.to_integer(raw)} end)
    end)
    |> List.flatten()
    |> Enum.into(%{})
  end

  def low_points(data) do
    data
    |> Map.keys()
    |> Enum.filter(fn p -> Enum.all?(adjacent_points(p), &(height(&1, data) > height(p, data)))end )
  end

  def adjacent_points({row,col} = _point) do
    [
      {row, col - 1},
      {row, col + 1},
      {row - 1, col},
      {row + 1, col},
    ]
  end

  def height(point, map) do
      Map.get(map, point, 9)
  end

  def grow_basin(point, map) do
    do_grow_basin(adjacent_points(point), map, %{point => 1})
  end

  def do_grow_basin([], _map, acc), do: acc
  def do_grow_basin(candidate_points, map, acc) do
    new_points = candidate_points
    |> Enum.reject(&(height(&1, map) == 9))
    |> Enum.reject(&(Map.has_key?(acc, &1)))
    |> Map.new(&({&1, 1}))

    acc = Map.merge(acc, new_points)

    new_points
    |> Map.keys()
    |> Enum.map(&adjacent_points/1)
    |> List.flatten()
    |> do_grow_basin(map, acc)
  end

  def basin_size(basin) do
    map_size(basin)
  end

end
