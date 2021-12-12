defmodule Aoc.Y2021.Day3 do
  import ShorterMaps
  import PredicateSigil

  defmodule Record do
    defstruct [
      raw: "",
      decimal: 0,
      digits: [],
    ]
  end

  def oxygen_gen(records) do
    filter_records(records, &most_common/2, 0)
  end
  def co2_scrub(records) do
    filter_records(records, &least_common/2, 0)
  end

  def filter_records([only_one], _value, _position), do: only_one.decimal
  def filter_records(records, value_fn, position) do
    keep = value_fn.(records, position)
    Enum.filter(records, fn ~M{digits} -> Enum.at(digits, position) == keep end)
    |> filter_records(value_fn, position+1)
  end

  def most_common(list, position) do
    %{0 => zeros, 1 => ones} = list
    |> Enum.map(fn ~M{digits} -> Enum.at(digits, position) end)
    |> Enum.frequencies()
    cond do
      zeros > ones -> 0
      ones > zeros -> 1
      true -> 1
    end
  end

  def least_common(list, position) do
    %{0 => zeros, 1 => ones} = list
    |> Enum.map(fn ~M{digits} -> Enum.at(digits, position) end)
    |> Enum.frequencies()
    cond do
      zeros < ones -> 0
      ones < zeros -> 1
      true -> 0
    end
  end

  def part_1 do
    data = load_data()
    gamma_rate(data) * epsilon_rate(data)
  end

  def part_2 do
    data = load_data()
    oxygen_gen(data) * co2_scrub(data)
  end

  def gamma_rate(data) do
    Enum.map(data, &(&1.digits))
    |> Enum.reduce(&add_list/2)
    |> Enum.map(fn d-> round(d/length(data)) end)
    |> Enum.join("")
    |> String.to_integer(2)
  end

  def epsilon_rate(data) do
    Enum.map(data, &(&1.digits))
    |> Enum.reduce(&add_list/2)
    |> Enum.map(fn d-> round(1 - d/length(data)) end)
    |> Enum.join("")
    |> String.to_integer(2)
  end

  def add_list(list1, list2) when length(list1) == length(list2) do
    do_add_list(list1, list2, [])
  end

  def do_add_list([], [], acc), do: Enum.reverse(acc)
  def do_add_list([h1|r1], [h2|r2], acc) do
    do_add_list(r1, r2, [h1+h2|acc])
  end



  def load_data() do
    File.read!("../data/2021/day_3.txt")
    |> process_lines()
  end

  def process_lines(string) do
    string
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(~p(""))
    |> Enum.map(&load_line/1)
  end

  def load_line(raw) do
    decimal = String.to_integer(raw, 2)
    digits = String.codepoints(raw) |> Enum.map(&String.to_integer/1)
    ~M{%Record raw, decimal, digits}
  end
end
