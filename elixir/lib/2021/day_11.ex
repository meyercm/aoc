defmodule Aoc.Y2021.Day11 do
  import ShorterMaps
  import PredicateSigil

  defmodule State do
    defstruct [
      flash_count: 0,
      items: %{},
    ]
  end

  def load_data() do
    File.read!("../data/2021/day_11.txt")
    |> parse_data()
  end

  def parse_data(raw) do
    items = raw
    |> String.split("\n")
    |> Enum.reject(~p(""))
    |> Enum.with_index()
    |> Enum.map(fn {l, row} ->
      String.codepoints(l)
      |> Enum.with_index()
      |> Enum.map(fn {v, col} ->
        {{row, col}, String.to_integer(v)}
      end)
    end)
    |> List.flatten()
    |> Map.new()
    ~M{%State items}
  end

  def step(~M{%State items} = state) do
    items = Map.new(items, fn {pos, value} -> {pos, value+1} end)
    ~M{%State state|items}
    |> flash_all(%{})
    |> zero_flashers()
  end

  def flash_all(~M{%State items} = state, last_flashers) do
    items
    |> Enum.filter(fn {_pos, v} -> v > 9 end)
    |> Enum.reject(fn {pos, _v} -> Map.has_key?(last_flashers, pos) end)
    |> case do
      [] -> state
      flashing ->
        %State{state|items: do_flashes(items, flashing)}
        |> flash_all(Map.merge(Map.new(flashing), last_flashers))
    end
  end

  def do_flashes(items, []), do: items
  def do_flashes(items, [{pos, _val}|rest]) do
    increment_neighbors(items, get_neighbors(pos))
    |> do_flashes(rest)
  end

  def increment_neighbors(items, []), do: items
  def increment_neighbors(items, [h|rest]) do
    if Map.has_key?(items, h) do
      Map.update!(items, h, &(&1+1))
      |> increment_neighbors(rest)
    else
      increment_neighbors(items, rest)
    end
  end

  def zero_flashers(~M{%State items, flash_count} = state) do
    flashers = Enum.filter(items, fn {_pos, value} -> value > 9 end)
    items = Enum.map(items,
      fn {pos, v} when v > 9 -> {pos, 0}
        other -> other
      end)
      |> Map.new()
    %State{state|items: items, flash_count: flash_count + Enum.count(flashers)}
  end

  def get_neighbors({row, col}) do
    [
      {row-1, col-1},
      {row-1, col},
      {row-1, col+1},
      {row, col-1},
      {row, col},
      {row, col+1},
      {row+1, col-1},
      {row+1, col},
      {row+1, col+1},
    ]
  end

  def part_1() do
    load_data()
    |> do_part_1()
  end

  def do_part_1(data) do
    Enum.reduce(1..100, data, fn _i, data -> step(data) end)
    |> Map.get(:flash_count)
  end

  def part_2() do
    load_data()
    |> do_part_2(1)
  end

  def do_part_2(~M{flash_count} = data, i) do
    case step(data) do
      %State{flash_count: new_count} when flash_count + 100 == new_count -> i
      next -> do_part_2(next, i+1)
    end
  end
end
