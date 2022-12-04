defmodule Aoc.Y2022.Day4 do
  import ShorterMaps
  import PredicateSigil

  def part_1(pairs) do
    pairs
    |> Enum.filter(&completely_contained?/1)
    |> Enum.count
  end

  def part_2(pairs) do
    pairs
    |> Enum.filter(&partially_contained?/1)
    |> Enum.count
  end

  def load_string(str) do
    String.split(str, "\n") 
    |> Enum.reject(~p(""))
    |> Enum.map(&parse_line/1)
  end

  def completely_contained?(~M{elf_1, elf_2}) do
    %{first: a1, last: b1} = elf_1
    %{first: a2, last: b2} = elf_2
    (a2 >= a1 and b1 >= b2) or (a1 >= a2 and b2 >= b1)
  end

  def partially_contained?(~M{elf_1, elf_2}) do
    not Range.disjoint?(elf_1, elf_2)
  end

  def parse_line(line) do
    [elf_1, elf_2] = line
                    |> String.split(",")
                    |> Enum.map(&parse_section/1)
    ~M{elf_1, elf_2}
  end

  def parse_section(section) do
    [first, last] = section
                    |> String.split("-")
                    |> Enum.map(&String.to_integer/1)
    first..last
  end


end
