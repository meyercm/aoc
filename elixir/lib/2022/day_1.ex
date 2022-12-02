defmodule Aoc.Y2022.Day1 do
  import PredicateSigil

  def load_string(str) do
    String.split(str, "\n\n")
    |> Enum.reject(~p(""))
    |> Enum.map(&load_elf/1)
  end

  def load_elf(str) do
    String.split(str, "\n")
    |> Enum.reject(~p(""))
    |> Enum.map(&String.to_integer/1)
  end

  def part_1(elves) do
    elves
    |> Enum.map(&Enum.sum/1)
    |> Enum.max()
  end

  def part_2(elves) do
    elves
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end
end
