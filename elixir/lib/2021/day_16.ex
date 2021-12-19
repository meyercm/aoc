defmodule Aoc.Y2021.Day16 do
  import ShorterMaps
  import PredicateSigil

  defmodule Packet do
    defstruct [
      version: nil,
      type: nil,
      value: nil,
    ]
  end

  def load_data() do
    File.read!("../data/2021/day_16.txt")
    |> parse_data()
  end

  def parse_data(raw) do
    number = raw
      |> String.trim()
      |> String.to_integer(16)
    len = 4 * String.length(raw)
    <<number::size(len)>>
    |> parse_packet()
  end

  def parse_packet(<<version::3, 4::3, rest::bits>>) do
    {value, remainder} = parse_value(4, rest, <<>>)
    type = :literal
    {~M{%Packet version, type, value}, remainder}
  end
  def parse_packet(<<version::3, type_raw::3, rest::bits>>) do
    type = parse_type(type_raw)
    {value, rem} = {[], <<>>}
    remainder = <<>>
    {~M{%Packet version, type, value}, remainder}
  end

  def parse_type(4), do: :literal
  def parse_type(operator), do: operator


  def parse_value(4, <<0::1, d::4, rest::bits>>, acc) do
    combined = <<acc::bits, d::4>>
    s = bit_size(combined)
    <<result::size(s)>> = combined
    {result, rest}
  end
  def parse_value(4, <<1::1, d::4, rest::bits>>, acc) do
    acc = <<acc::bits, d::4>>
    parse_value(4, rest, acc)
  end

  def part_1() do
    load_data()
    |> do_part_1()
  end

  def do_part_1(data) do
  end

  def part_2() do
    load_data()
    |> do_part_2()
  end

  def do_part_2(data) do
  end

end
