defmodule Aoc.Y2022.Day2 do
  import PredicateSigil
  def part_1(strategy) do
    Enum.map(strategy, &score_round/1)
    |> Enum.sum()
  end

  def load_string_1(str) do
    String.split(str, "\n")
    |> Enum.reject(~p(""))
    |> Enum.map(&read_round_1(&1))
  end

  def load_string_2(str) do
    String.split(str, "\n")
    |> Enum.reject(~p(""))
    |> Enum.map(&read_round_2(&1))
  end

  def read_round_1(str) do
    String.split(str)
    |> Enum.map(&convert_symbol/1)
  end

  def read_round_2(str) do
    convert_symbol_2(str)
  end

  def convert_symbol("A"), do: :rock
  def convert_symbol("B"), do: :paper
  def convert_symbol("C"), do: :scissors

  def convert_symbol("X"), do: :rock
  def convert_symbol("Y"), do: :paper
  def convert_symbol("Z"), do: :scissors

  def convert_symbol_2("A X"), do: [:rock, :scissors]
  def convert_symbol_2("A Y"), do: [:rock, :rock]
  def convert_symbol_2("A Z"), do: [:rock, :paper]
  def convert_symbol_2("B X"), do: [:paper, :rock]
  def convert_symbol_2("B Y"), do: [:paper, :paper]
  def convert_symbol_2("B Z"), do: [:paper, :scissors]
  def convert_symbol_2("C X"), do: [:scissors, :paper]
  def convert_symbol_2("C Y"), do: [:scissors, :scissors]
  def convert_symbol_2("C Z"), do: [:scissors, :rock]

  def score_round([theirs, mine]) do
    my_score(mine) + win_score(theirs, mine)
  end

  def my_score(:rock), do: 1
  def my_score(:paper), do: 2
  def my_score(:scissors), do: 3

  def win_score(same, same), do: 3
  def win_score(:rock, :scissors), do: 0
  def win_score(:scissors, :paper), do: 0
  def win_score(:paper, :rock), do: 0
  def win_score(_,_), do: 6
end
