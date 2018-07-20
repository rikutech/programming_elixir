defmodule MyEnum do
  def all?([head|tail], func) do
    if func.(head), do: all?(tail, func), else: false
  end
  def all?([], _), do: true

  def each([head|tail], func) do
    func.(head)
    each(tail, func)
  end
  def each([], _), do: true

  def filter([head|tail], func) do
    if func.(head), do: [head|filter(tail, func)], else: filter(tail, func)
  end
  def filter([], _), do: []

  def flatten(all = [head|tail]) when is_list(head) do
    IO.puts "is_list"
    IO.inspect all
    [flatten(tail)|flatten(head)]
  end
  def flatten(all = [head|tail]) do
    IO.puts "is_single"
    IO.inspect all
    [flatten(tail)|[head]]
  end
  def flatten([]), do: []
end


defmodule Main do
  def main do
    list = Enum.to_list 1..5
    IO.inspect Enum.map(list, &String.duplicate("*", &1))
    require Integer
    IO.inspect Enum.filter(list, &Integer.is_even/1)
    IO.inspect Enum.reject(list, &Integer.is_even/1)
    IO.inspect Enum.join(list)
  end
end
