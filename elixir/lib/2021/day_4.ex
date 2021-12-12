defmodule Aoc.Y2021.Day4 do
  import ShorterMaps
  import PredicateSigil

  defmodule Data do
    defstruct [
      sequence: [],
      boards: [],
    ]
  end

  defmodule Board do
    defstruct [
      spots: [],
      mask: [],
      used: [],
    ]
    def parse(raw) do
      spots = String.split(raw)
              |> Enum.reject(~p(""))
              |> Enum.map(&String.to_integer/1)
      mask = Stream.cycle([0]) |> Enum.take(length(spots))
      ~M{%Board spots, mask}
    end
    def get(~M{spots}, row, col) do
      Enum.at(spots, row * 5 + col)
    end

    def check_off(~M{spots, mask, used} = board, number) do
      if (has_won(board)) do
        board
      else
        used = [number|used]
        case Enum.find_index(spots, ~p(^number)) do
          nil -> ~M{%Board board|used}
          idx ->
            mask = List.replace_at(mask, idx, 1)
            ~M{%Board board|mask, used}
        end
      end
    end

    def is_checked(~M{spots, mask}, number) do
      case Enum.find_index(spots, ~p(^number)) do
        nil -> nil
        idx -> Enum.at(mask, idx) == 1
      end
    end

    def has_won(board) do
      ways = for item <- 0..4 do
        [row_checked(board, item), col_checked(board, item)]
      end |> List.flatten()
      Enum.any?(ways)
    end

    def row_checked(~M{mask}, row_num) do
      for j <- 0..4 do
        Enum.at(mask, row_num * 5 + j)
      end
      |> Enum.sum() == 5
    end

    def col_checked(~M{mask}, col_num) do
      for j <- 0..4 do
        Enum.at(mask, j * 5 + col_num)
      end
      |> Enum.sum() == 5
    end

    def score(~M{spots, mask, used}) do
      multiplier = hd(used)
      sum = Enum.zip(spots, mask)
        |> Enum.filter(~p({_, 0}))
        |> Enum.map(fn {s, 0} -> s end)
        |> Enum.sum()

      multiplier * sum
    end
  end

  def load_data() do
    File.read!("../data/2021/day_4.txt")
    |> parse_data()
  end

  def part_1() do
    ~M{sequence, boards} = load_data()
    Enum.map(boards, fn b -> Enum.reduce(sequence, b, &(Board.check_off(&2, &1))) end)
    |> Enum.sort_by(fn b-> length(b.used) end)
    |> hd()
    |> Board.score()
  end

  def part_2() do
    ~M{sequence, boards} = load_data()
    Enum.map(boards, fn b -> Enum.reduce(sequence, b, &(Board.check_off(&2, &1))) end)
    |> Enum.sort_by(fn b-> length(b.used) end)
    |> Enum.reverse
    |> hd()
    |> Board.score()
  end

  def parse_data(raw) do
    [first | rest] = raw
    |> String.split("\n\n")
    sequence = read_sequence(first)
    boards = read_boards(rest)
    ~M{%Data sequence, boards}
  end

  def read_sequence(raw) do
    String.split(raw, ",")
    |> Enum.map(&String.to_integer/1)
  end

  def read_boards(raws) do
    raws
    |> Enum.map(&Board.parse/1)
  end
end
