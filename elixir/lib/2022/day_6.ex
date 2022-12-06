defmodule Aoc.Y2022.Day6 do
  import ShorterMaps
  import PredicateSigil

  def part_1(input) do
    scan_for_unique(input, 4)
  end

  def part_2(input) do
    scan_for_unique(input, 14)
  end

  def load_string(str) do
    String.codepoints(str)
  end

  def scan_for_unique([h| next] = list, count, acc \\ 0) do
    {window, _rest} = Enum.split(list, count)
    case length(Enum.uniq(window)) do
      ^count -> acc + count
      _ -> scan_for_unique(next, count, acc+1)
    end
  end


end
