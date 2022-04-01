defmodule Aoc.Y2021.Day24 do
  import ShorterMaps
  import PredicateSigil
  require Logger

  @registers ["w", "x", "y", "z"]

  defmodule ALU do
    defstruct [
      input: [],
      w: 0,
      x: 0,
      y: 0,
      z: 0,
    ]
    @registers ["w", "x", "y", "z"]
    @register_keys Enum.map(@registers, &String.to_atom/1)

    def new(input) do
      ~M{%ALU input}
    end

    def symbolic_collapse(instructions, acc \\ %{w: 0, x: 0, y: 0, z: 0, input: 0})
    def symbolic_collapse([], acc), do: acc
    def symbolic_collapse([h|rest], acc) do
      acc = collapse_step(h, acc)
      symbolic_collapse(rest, acc)
    end

    def collapse_step({:inp, key}, ~M{input} = acc) do
      input_item = "input_#{input}" |> String.to_atom()
      Map.put(acc, key, input_item)
      |> Map.put(:input, input+1)
    end
    def collapse_step({op, key, reg}, acc) when reg in @register_keys do
      collapse_step(key, {op, Map.get(acc, key), Map.get(acc, reg)}, acc)
    end
    def collapse_step({op, key, val}, acc) when key in @register_keys do
      collapse_step(key, {op, Map.get(acc, key), val}, acc)
    end


    def collapse_step(_reg, {:add, _a, 0}, acc), do: acc
    # def collapse_step(reg, {:add, a, b}, acc) when is_integer(a) and is_integer(b), do: Map.put(acc, reg, a + b)
    def collapse_step(_reg, {:mul, _a, 1}, acc), do: acc
    def collapse_step(reg, {:mul, 1, b}, acc), do: Map.put(acc, reg, b)
    def collapse_step(reg, {:mul, _a, 0}, acc), do: Map.put(acc, reg, 0)
    def collapse_step(reg, {:mul, 0, _b}, acc), do: Map.put(acc, reg, 0)
    # def collapse_step(reg, {:mul, a, b}, acc) when is_integer(a) and is_integer(b), do: Map.put(acc, reg, a * b)
    def collapse_step(_reg, {:div, _key, 1}, acc), do: acc
    def collapse_step(reg, {:div, a, a}, acc), do: Map.put(acc, reg, 1)
    # def collapse_step(reg, {:div, a, b}, acc) when is_integer(a) and is_integer(b), do: Map.put(acc, reg, div(a, b))
    def collapse_step(reg, {:eql, a, a}, acc), do: Map.put(acc, reg, 1)
    # def collapse_step(reg, {:eql, a, b}, acc) when is_integer(a) and is_integer(b), do: Map.put(acc, reg, eql(a, b))
    def collapse_step(_reg, {:mod, _a, 1}, acc), do: acc
    # def collapse_step(reg, {:mod, a, b}, acc) when is_integer(a) and is_integer(b), do: Map.put(acc, reg, rem(a, b))

    def collapse_step(reg, operation, acc) do
      val = simplify(operation)
      Map.put(acc, reg, val)
    end

    def eql(a, a) when is_integer(a), do: 1
    def eql(a, b) when is_integer(a) and is_integer(b), do: 0

    def simplify(~M{%ALU w, x, y, z} = alu) do
      %ALU{alu |
        w: simplify(w),
        x: simplify(x),
        y: simplify(y),
        z: simplify(z)
    }
    end
    def simplify(value) when not is_tuple(value), do: value
    def simplify({:add, a, b}) when is_integer(a) and is_integer(b), do: a + b
    def simplify({:mul, a, b}) when is_integer(a) and is_integer(b), do: a * b
    def simplify({:div, a, b}) when is_integer(a) and is_integer(b), do: div(a, b)
    def simplify({:mod, a, b}) when is_integer(a) and is_integer(b), do: rem(a, b)
    def simplify({:eql, a, b}) when is_integer(a) and is_integer(b), do: eql(a, b)
    def simplify({:add, 0, b}), do: b
    def simplify({:add, a, 0}), do: a
    def simplify({:mul, _a, 0}), do: 0
    def simplify({:mul, 0, _b}), do: 0
    def simplify({:mul, a, 1}), do: a
    def simplify({:mul, 1, b}), do: b
    def simplify({:div, 0, _b}), do: 0
    def simplify({:div, a, 1}), do: a
    def simplify({:div, a, a}), do: 1
    def simplify({:mod, a, 1}), do: a
    def simplify({:mod, a, a}), do: 0
    def simplify({:mod, {:mul, a, _b}, a}), do: 0
    def simplify({:mod, {:mul, _a, b}, b}), do: 0
    def simplify({:eql, a, a}), do: 1
    def simplify({:eql, a, b}) when is_atom(a) and is_integer(b) and b > 9, do: 0
    def simplify({:eql, b, a}) when is_atom(a) and is_integer(b) and b > 9, do: 0
    def simplify({:eql, a, b}) when is_atom(a) and is_integer(b) and b > 9, do: 0
    def simplify({:eql, a, b}) when is_atom(b) do
      new_a = simplify(a)
      if get_minimum(new_a) > 9 or get_maximum(new_a) < 1, do: 0, else: {:eql, new_a, b}
    end
    def simplify({:eql, a, b}) when is_atom(a) do
      new_b = simplify(b)
      if get_minimum(new_b) > 9 or get_maximum(new_b) < 1, do: 0, else: {:eql, a, new_b}
    end

    def simplify({op, a, b}), do: {op, simplify(a), simplify(b)}

    def get_minimum(val) when is_integer(val), do: val
    def get_minimum(val) when is_atom(val), do: 1
    def get_minimum({:add, a, b}), do: get_minimum(a) + get_minimum(b)
    def get_minimum({:mul, a, b}), do: get_minimum(a) * get_minimum(b)
    def get_minimum({:div, _a, _b}), do: 0
    def get_minimum({:mod, _a, _b}), do: 0
    def get_minimum({:eql, _a, _b}), do: 0

    def get_maximum(val) when is_integer(val), do: val
    def get_maximum(val) when is_atom(val), do: 9
    def get_maximum({:add, a, b}), do: get_maximum(a) + get_maximum(b)
    def get_maximum({:mul, a, b}), do: get_maximum(a) * get_maximum(b)
    def get_maximum({:div, a, _b}), do: get_maximum(a)
    def get_maximum({:mod, _a, b}), do: get_maximum(b) - 1
    def get_maximum({:eql, _a, _b}), do: 1

    def stringify(:add), do: "+"
    def stringify(:mul), do: "*"
    def stringify(:div), do: "/"
    def stringify(:mod), do: "%"
    def stringify(:eql), do: "=="
    def stringify(val) when is_atom(val) or is_number(val), do: val
    def stringify({op, a, b}), do: "(#{stringify(a)}#{stringify(op)}#{stringify(b)})"

    def run(%ALU{} = alu, instructions) do
      Enum.reduce(instructions, alu, &execute_step/2)
    end

    def run_thru(%ALU{input: []} = alu, [{:inp, _}| _]) do
      alu
    end
    def run_thru(%ALU{} = alu, []), do: alu
    def run_thru(%ALU{} = alu, [h|instructions]) do
      execute_step(h, alu)
      |> run_thru(instructions)
    end
    def execute_step(instr, alu)
    def execute_step({:inp, reg}, ~M{input: [h|rest]}=alu) do
      alu
      |> Map.put(:input, rest)
      |> Map.put(reg, h)
    end
    def execute_step({:add, reg, val}, alu) do
      result = get_param(alu, reg) + get_param(alu, val)
      Map.put(alu, reg, result)
    end
    def execute_step({:mul, reg, val}, alu) do
      result = get_param(alu, reg) * get_param(alu, val)
      Map.put(alu, reg, result)
    end
    def execute_step({:div, reg, val}, alu) do
      result = div(get_param(alu, reg), get_param(alu, val))
      Map.put(alu, reg, result)
    end
    def execute_step({:mod, reg, val}, alu) do
      result = rem(get_param(alu, reg), get_param(alu, val))
      Map.put(alu, reg, result)
    end
    def execute_step({:eql, reg, val}, alu) do
      result = if get_param(alu, reg) == get_param(alu, val), do: 1, else: 0
      Map.put(alu, reg, result)
    end

    def get_param(_alu, value) when is_integer(value), do: value
    def get_param(alu, reg) when is_atom(reg), do: Map.get(alu, reg)
  end

  def load_data() do
    File.read!("../data/2021/day_24.txt")
    |> parse_data()
  end

  def parse_data(raw) do
    String.split(raw, "\n")
    |> Enum.reject(~p(""))
    |> Enum.map(fn l ->
      String.split(l, " ")
      |> parse_line()
    end)
  end


  def parse_line(parts)
  def parse_line(["inp", a]), do: {:inp, fix_param(a)}
  def parse_line(["add", a, b]), do: {:add, fix_param(a), fix_param(b)}
  def parse_line(["mul", a, b]), do: {:mul, fix_param(a), fix_param(b)}
  def parse_line(["div", a, b]), do: {:div, fix_param(a), fix_param(b)}
  def parse_line(["mod", a, b]), do: {:mod, fix_param(a), fix_param(b)}
  def parse_line(["eql", a, b]), do: {:eql, fix_param(a), fix_param(b)}

  def fix_param(reg) when reg in @registers, do: String.to_atom(reg)
  def fix_param(int), do: String.to_integer(int)
  def part_1() do
    load_data()
    |> do_part_1()
  end

  def do_part_1(data) do
    data
    |> log("loaded")
    |> ALU.symbolic_collapse()
    |> log("collapsed")
    |> Map.get(:z)
    |> ALU.simplify
    |> log("simplified")
    |> ALU.stringify
  end

  def log(val, string) do
    Logger.error(string)
    val
  end

  def part_2() do
    load_data()
    |> do_part_2()
  end

  def do_part_2(data) do
  end

end
