defmodule Aoc.Y2021.Day22 do
  import ShorterMaps
  import PredicateSigil

  defmodule Step do
    defstruct [
      on: false,
      x: 0..0,
      y: 0..0,
      z: 0..0,
    ]
  end

  def load_data() do
    File.read!("../data/2021/day_22.txt")
    |> parse_data()
  end

  def parse_data(raw) do
    String.split(raw, "\n")
    |> Enum.reject(~p(""))
    |> Enum.map(fn l ->
      [on_off, coords] = String.split(l, " ")
      [x, y, z] = String.split(coords, ",")
      |> Enum.map(&parse_coords/1)
      on = (on_off == "on")
      ~M{%Step on, x, y, z}
    end)
  end

  def parse_coords(raw) do
    [_, range] = String.split(raw, "=")
    [start, stop] = String.split(range, "..")
                    |> Enum.map(&String.to_integer/1)
    start..stop
  end

  def apply_step(~M{on, x, y, z}, reactor) do
    for x_n <- x, y_n <- y, z_n <- z do
      {{x_n, y_n, z_n}, on}
    end
    |> Enum.reduce(reactor, fn
      {k, true}, acc -> Map.put(acc, k, true)
      {k, false}, acc -> Map.delete(acc, k)
    end)
  end

  def magnitude(~M{on, x, y, z}) do
    size = Range.size(x) * Range.size(y) * Range.size(z)
    if (on) do
      size
    else
      size * -1
    end
  end

  def disjoint(%{x: x1, y: y1, z: z1},%{x: x2, y: y2, z: z2}) do
    Range.disjoint?(x1, x2) or Range.disjoint?(y1, y2) or Range.disjoint?(z1, z2)
  end

  @init -50..50
  @init_region %{x: @init, y: @init, z: @init}
  def outside_init?(step), do: disjoint(@init_region, step)

  @quadrants [
    %{x: {:gt, 0}, y: {:gt, 0}, z: {:gt, 0} },
    %{x: {:gt, 0}, y: {:gt, 0}, z: {:lt, 0} },
    %{x: {:gt, 0}, y: {:lt, 0}, z: {:gt, 0} },
    %{x: {:gt, 0}, y: {:lt, 0}, z: {:lt, 0} },
    %{x: {:lt, 0}, y: {:gt, 0}, z: {:gt, 0} },
    %{x: {:lt, 0}, y: {:gt, 0}, z: {:lt, 0} },
    %{x: {:lt, 0}, y: {:lt, 0}, z: {:gt, 0} },
    %{x: {:lt, 0}, y: {:lt, 0}, z: {:lt, 0} },
  ]
  def do_part_1_alt(data) do
    @quadrants
    |> Enum.map(fn q->
      data
      |> apply_section(q)
      |> do_part_1
    end)
    |> Enum.sum()
  end

  def apply_section(steps, %{x: x_limit, y: y_limit, z: z_limit}) do
    Enum.map(steps, fn s ->
      %{s|
          x: limit_coord(s.x, x_limit),
          y: limit_coord(s.y, y_limit),
          z: limit_coord(s.z, z_limit)}
    end)
    |> Enum.reject(~p(%{x: nil}))
    |> Enum.reject(~p(%{y: nil}))
    |> Enum.reject(~p(%{z: nil}))

  end

  def do_part_1_alt_alt(data) do
    reversed = Enum.reverse(data)
       |> Enum.reject(&outside_init?/1)
    x_es = get_coords(data, :x)
    y_es = get_coords(data, :y)
    z_es = get_coords(data, :z)

    for x_s..x_e <- x_es,
        y_s..y_e <- y_es,
        z_s..z_e <- z_es do
      if is_on?(reversed, {x_s, y_s, z_s}) do
        (x_e - x_s) * (y_e - y_s) * (z_e - z_s)
      else
        0
      end
    end
    |> Enum.sum
  end

  def is_on?(reversed, point) do
    reversed
    |> Stream.filter(&contains_point?(&1, point))
    |> Enum.take(1)
    |> case do
      [] -> false
      [~M{on}] -> on
    end
  end

  def contains_point?(%{x: x_s..x_e, y: y_s..y_e, z: z_s..z_e}, {x, y, z}) do
    x_s <= x and x_e >= x and
    y_s <= y and y_e >= y and
    z_s <= z and z_e >= z
  end

  def get_coords(data, key) do
    coords =
    Enum.map(data, fn step ->
      start..stop = Map.get(step, key)
      [start, stop+1]
    end)
    |> List.flatten
    |> Enum.sort()
    |> Enum.uniq()

    coords
    |> Enum.zip(Enum.drop(coords, 1))
    |> Enum.map(fn {s, e} -> s..e end)
  end

  def limit_coord(_start..stop, {:gt, val}) when stop < val, do: nil
  def limit_coord(start..stop, {:gt, val}) when start < val, do: val..stop
  def limit_coord(start.._stop, {:lt, val}) when start >= val, do: nil
  def limit_coord(start..stop, {:lt, val}) when stop >= val, do: start..val-1
  def limit_coord(orig, _), do: orig

  def part_1() do
    load_data()
    |> do_part_1()
  end

  def do_part_1(data) do
    data
    |> Enum.reject(&outside_init?/1)
    |> Enum.reduce(%{}, &apply_step/2)
    |> Enum.count
  end

  def part_2() do
    load_data()
    |> do_part_2()
  end

  def do_part_2(data) do
    Enum.map(data, &magnitude/1)
    |> IO.inspect
  end

end
