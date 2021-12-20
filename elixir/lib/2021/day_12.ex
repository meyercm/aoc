defmodule Aoc.Y2021.Day12 do
  import ShorterMaps
  import PredicateSigil


  def load_data() do
    File.read!("../data/2021/day_12.txt")
    |> parse_data()
  end

  def parse_data(raw) do
    String.split(raw, "\n")
    |> Enum.reject(~p(""))
    |> Enum.map(fn l ->
      [a, b] = String.split(l, "-")
      [{a, b}, {b, a}]
    end)
    |> List.flatten()
    |> Enum.reduce(%{}, fn {k,v}, map ->
      Map.update(map, k, [v], fn l -> [v|l] end)
    end)
  end

  def get_all_paths(map) do
    do_get_path(map, ["start"], [])
    |> Enum.filter(~p(["end"|_rest]))
  end
  def do_get_path(_map, ["end"|_rest] = so_far, acc), do: [so_far|acc]
  def do_get_path(map, [node|_rest] = so_far, acc) do
    next = Map.get(map, node, [])
    map = update_map(map, node)
    next
    |> Enum.reduce(acc, fn n, a ->
      do_get_path(map, [n|so_far], a)
    end)
  end

  def update_map(map, node) do
    map = if starts_upper?(node) do
      map
    else
      drop_paths(map, node)
    end
  end

  def drop_paths(map, node) do
    map
    |> Map.delete(node)
    |> Enum.map(fn {k, v} ->
      {k, Enum.reject(v, ~p(^node))}
    end)
    |> Map.new()
  end

  def starts_upper?(string) do
    first = String.at(string, 0)
    first == String.upcase(first)
  end

  def part_1() do
    load_data()
    |> do_part_1()
  end

  def do_part_1(data) do
    data
    |> get_all_paths()
    |> Enum.count()
  end

  def part_2() do
    load_data()
    |> do_part_2()
  end

  def do_part_2(data) do
    data
    |> Map.put(:revisits, 1)
    |> get_all_paths()
    |> Enum.count()
  end

end
