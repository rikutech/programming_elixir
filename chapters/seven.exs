defmodule MyList do
  def len([]), do: 0
  def len([_|tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head|tail]), do: [head*head|square(tail)]

  def add_1([]), do: []
  def add_1([head|tail]), do: [head+1|add_1(tail)]

  def map([], _func), do: []
  def map([head|tail], func), do: [func.(head)|map(tail, func)]

  def sum(list), do: _sum(list, 0)
  defp _sum([], total), do: total
  defp _sum([head|tail], total), do: _sum(tail, head + total)

  def reduce([], value, _), do: value
  def reduce([head|tail], value, func), do: reduce(tail, func.(head, value), func)

  def mapsum(list, func), do: _mapsum(list, 0, func)
  defp _mapsum([], value, _), do: value
  defp _mapsum([head|tail], value, func), do: _mapsum(tail, value + func.(head), func)

  def max(list), do: _max(list, 0)
  defp _max([], v), do: v
  defp _max([head|tail], v) when v < head, do: _max(tail, head)
  defp _max([head|tail], v) when v >= head, do: _max(tail, v)

  def span(from, to), do: from..to
end
