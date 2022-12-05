defmodule Aoc.Y2022.Day5 do
  import ShorterMaps
  import PredicateSigil

  def part_1({stacks, directions}) do
    count = Map.keys(stacks) |> Enum.count()
    final = Enum.reduce(directions, stacks, &apply_direction/2)
    top_layer = for i <- 1..count, do: final |> Map.get(i) |> Enum.at(0, " ")
    Enum.join(top_layer)
  end

  def part_2({stacks, directions}) do
    count = Map.keys(stacks) |> Enum.count()
    final = Enum.reduce(directions, stacks, &apply_direction_bulk/2)
    top_layer = for i <- 1..count, do: final |> Map.get(i) |> Enum.at(0, " ")
    Enum.join(top_layer)
  end

  def load_string(str) do
    [stacks_raw, directions_raw] = String.split(str, "\n\n")
    {load_stacks(stacks_raw), load_directions(directions_raw)}
  end

  def load_stacks(stacks_raw) do
    [labels|stack_lines] = String.split(stacks_raw, "\n")
                  |> Enum.reverse()
                  |> Enum.reject(~p(""))
    count = labels |> String.codepoints() |> Enum.reject(~p(" ")) |> Enum.count()
    stack_lines
    |> Enum.reduce(%{}, parse_stack_line(count))
  end


  ## curry the count into the reducer function
  def parse_stack_line(count) do
    fn line, acc ->
      for i <- 1..count do
        {i, String.at(line, i*4-3)}
      end
      |> Enum.reduce(acc,
        fn {_i, " "}, a -> a
           {i, letter}, a-> put_in(a[i], [letter|Map.get(a, i, [])])
        end)
    end
  end

  def load_directions(directions_raw) do
    String.split(directions_raw, "\n")
    |> Enum.reject(~p(""))
    |> Enum.map(&parse_directions_line/1)
  end

  def parse_directions_line(str) do
    ["move", count, "from", from, "to", to] = String.split(str)
    ~M{count, from, to}
    |> Map.new(fn {k, v} -> {k, String.to_integer(v)} end)
  end


  def apply_direction(~M{count: 0}, stacks), do: stacks
  def apply_direction(~M{count, from, to}, stacks) do
    [item|old] = stacks[from]
    new = [item|stacks[to]]
    updated = stacks
              |> Map.put(from, old)
              |> Map.put(to, new)
    apply_direction(~M{count: count-1, from, to}, updated)
  end

  def apply_direction_bulk(~M{count, from, to}, stacks) do
    {pile, old} = Enum.split(stacks[from], count)
    new = pile ++ stacks[to]
    stacks
    |> Map.put(from, old)
    |> Map.put(to, new)
  end

end
