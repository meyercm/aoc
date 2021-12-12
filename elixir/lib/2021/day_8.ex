defmodule Aoc.Y2021.Day8 do
  import ShorterMaps
  import PredicateSigil

  defmodule Record do
    defstruct [
      raw: "",
      left: [],
      right: [],
      mapping: %{},
    ]
  end

  def part_1() do
    load_data()
    |> Enum.map(&part_1_count/1)
    |> Enum.sum()
  end

  def part_2() do
    load_data()
    |> Enum.map(&decoded/1)
    |> Enum.sum()
  end

  def part_1_count(~M{%Record right}) do
    Enum.count(right, &(Enum.member?([2, 3, 4, 7], String.length(&1))))
  end

  def decoded(%Record{mapping: m, right: [a,b,c,d]}) do
    m[a] * 1000 +
    m[b] * 100 +
    m[c] * 10 +
    m[d]
  end

  def load_data() do
    File.read!("../data/2021/day_8.txt")
    |> String.split("\n")
    |> Enum.reject(~p(""))
    |> Enum.map(&load_line/1)
  end

  def load_line(raw) do
    [left_raw, right_raw] = String.split(raw, "|")
    left = load_side(left_raw)
    right = load_side(right_raw)
    mapping = create_mapping(left)
    ~M{%Record raw, left, right, mapping}
  end

  def create_mapping(left) do
    result = map_easy(left)
    result
  end

  def map_easy(left) do
    [one, seven, four, o235_1, o235_2, o235_3, o069_1, o069_2, o069_3, eight] = Enum.sort_by(left, &String.length/1)
    [zero, six, nine] = map_069([o069_1, o069_2, o069_3], one, four)
    [two, three, five] = map_235([o235_1, o235_2, o235_3], one, six)
    %{zero => 0,
      one => 1,
      two => 2,
      three => 3,
      four => 4,
      five => 5,
      six => 6,
      seven => 7,
      eight => 8,
      nine => 9,
    }
  end

  def map_235(options, one, six) do
    three = Enum.find(options, fn o -> String.length(common(o, one)) == 2 end)
    five = Enum.find(options, fn o -> String.length(common(o, six)) == 5 end)
    [two] = options |> Enum.reject(~p(^three)) |> Enum.reject(~p(^five))
    [two, three, five]
  end

  def map_069(options, one, four) do
    six = Enum.find(options, fn o -> String.length(common(o, one)) == 1 end)
    nine = Enum.find(options, fn o -> String.length(common(o, four)) == 4 end)
    [zero] = options |> Enum.reject(~p(^six)) |> Enum.reject(~p(^nine))
    [zero, six, nine]
  end

  def common(a, b) do
    String.codepoints(a)
    |> Enum.filter(fn c -> String.contains?(b, c) end)
    |> Enum.sort()
    |> Enum.into("")
  end

  @spec load_side(String.t()) :: list(String.t())
  def load_side(side_raw) do
    side_raw
    |> String.split()
    |> Enum.reject(~p(""))
    |> Enum.map(&normalize_code/1)
  end

  @spec normalize_code(String.t()) :: String.t()
  def normalize_code(str) do
    String.codepoints(str)
    |> Enum.sort()
    |> Enum.into("")
  end
end
