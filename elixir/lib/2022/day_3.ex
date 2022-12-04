defmodule Aoc.Y2022.Day3 do
  import ShorterMaps
  import PredicateSigil

  def part_1(backpacks) do
    backpacks
    |> Stream.map(&find_common/1)
    |> Stream.map(&get_score/1)
    |> Enum.sum()
  end

  def part_2(backpacks) do
    backpacks
    |> Stream.map(&(&1.sorted))
    |> Stream.chunk_every(3)
    |> Stream.map(fn group ->
        do_common_a(group)
        |> get_score()
      end)
    |> Enum.sum()
  end

  def load_string(str) do
    String.split(str, "\n") 
    |> Enum.reject(~p(""))
    |> Enum.map(&parse_line/1)
  end

  def parse_line(line) do
    half = trunc(String.length(line) / 2)
    {front, back} = String.split_at(line, half)
    sorted = String.to_charlist(line) |> Enum.sort()
    ~M{front, back, sorted}
  end

  def find_common(~M{front, back}) do
    sorted_front = String.to_charlist(front) |> Enum.sort()
    sorted_back = String.to_charlist(back) |> Enum.sort()
    do_find_common(sorted_front, sorted_back)
  end

  def do_find_common([match|_other_front], [match|_other_back]), do: List.to_string([match])
  def do_find_common([a|rest_front], [b|_rest_back] = back)
      when a < b, do: do_find_common(rest_front, back)
  def do_find_common([_a|_rest_front] = front, [_b|rest_back]), do: do_find_common(front, rest_back)


  def get_score(letter) do
    [ascii] = String.to_charlist(letter)
    if ascii > 90 do #lowercase
      ascii - 96
    else
      ascii - 38
    end
  end


  def do_common_a(list), do: do_common_b(Enum.sort(list))

  def do_common_b([[same|_], [same|_], [same|_]]), do: List.to_string([same])
  def do_common_b([[same|a], [same|b], [_diff|_] = c]), do: do_common_a([a, b, c])
  def do_common_b([[_x|a], [_y|_] = b, [_z|_] = c]), do: do_common_a([a, b, c])

end
