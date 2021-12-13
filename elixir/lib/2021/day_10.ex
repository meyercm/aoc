defmodule Aoc.Y2021.Day10 do
  import ShorterMaps
  import PredicateSigil

  @open_chars ["(", "[", "{", "<"]
  @close_chars [")", "]", "}", ">"]
  @closing Enum.zip(@open_chars, @close_chars) |> Map.new
  @opening Enum.zip(@close_chars, @open_chars) |> Map.new

  @completion_point_vals %{")" => 1, "]" => 2, "}" => 3, ">" => 4}

  @error_point_vals %{")" => 3, "]" => 57, "}" => 1197, ">" => 25137}

  def load_data() do
    File.read!("../data/2021/day_10.txt")
    |> parse_data()
  end

  def parse_data(raw) do
    raw
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(~p(""))
    |> Enum.map(&parse_line/1)
  end

  def parse_line(raw) do
    String.codepoints(raw)
  end

  def first_error(item) do
    item
    |> Enum.reduce([], &update_stack/2)
    |> case do
      {:error, {:illegal, char}} -> char
      _ -> nil
    end
  end

  def completing_sequence(item) do
    Enum.reduce(item, [], &update_stack/2)
    |> Enum.map(&(Map.get(@closing, &1)))
  end

  def completion_points(closing_sequence) do
    Enum.reduce(closing_sequence, 0, fn char, acc ->
      acc * 5 + @completion_point_vals[char]
    end)
  end

  def part_1() do
    load_data()
    |> do_part_1()
  end

  def do_part_1(data) do
    data
    |> Enum.map(&first_error/1)
    |> Enum.reject(~p(nil))
    |> Enum.map(&error_points/1)
    |> Enum.sum()
  end

  def part_2() do
    load_data()
    |> do_part_2()
  end

  def do_part_2(data) do
    all_points = data
    |> Enum.filter(fn item -> nil == first_error(item) end)
    |> Enum.map(fn item ->
      item
      |> completing_sequence()
      |> completion_points()
    end)
    |> Enum.sort()

    count = length(all_points)
    middle = div(count, 2)

    Enum.at(all_points, middle)
  end

  def error_points(illegal_char), do: Map.get(@error_point_vals, illegal_char, 0)

  def update_stack(char, stack)
  def update_stack(_, {:error, _e} = error), do: error
  def update_stack(")", ["("|rest]), do: rest
  def update_stack("]", ["["|rest]), do: rest
  def update_stack("}", ["{"|rest]), do: rest
  def update_stack(">", ["<"|rest]), do: rest
  def update_stack(open, acc) when open in @open_chars, do: [open|acc]
  def update_stack(close, [hd|acc]) when close in @close_chars do
    {:error, {:illegal, close}}
  end

end
