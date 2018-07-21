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


#Stream 遅延列挙
odds = [1,2,3,4]
|> Stream.map(&(&1 * &1))
|> Stream.map(&(&1+1))
|> Stream.filter(fn x -> rem(x,2) == 1 end)
#Enumモジュールの関数を使って初めて評価される
IO.inspect Enum.to_list odds

Stream.map(1..10_000_000, &(&1+1)) |> Enum.take(5)

#新しい値が必要になったときに都度実行される
IO.inspect Stream.repeatedly(fn  -> true end) |> Enum.take(3)
IO.inspect Stream.repeatedly(fn  -> true end) |> Enum.take(5)

#無限ストリームの生成 初期値と適用関数を渡す　結果が次の初期値になる　ストリームが使われている限り続ける
IO.inspect Stream.iterate(0, &(&1+1)) |> Enum.take(5)
#フィボナッチ数列の実装 初期値のタプルと関数を渡すと、適用されて1つずつずれていく
IO.inspect Stream.unfold({0, 1}, fn {f1, f2} -> {f1, {f2, f1+f2}} end) |> Enum.take(15)

#内包表記
IO.inspect for x <- [1,2,3,4,5], do: x * x
IO.inspect for x <- [1,2,3,4,5], x < 4, do: x * x

#フィルタに引っかかった場合、後のdoは評価されない
list8 = [1,2,3,4,5,6,7,8]
IO.inspect for x <- list8, y <- list8, x >= y, rem(x*y, 10)==0, do: {x,y}

#intoパラメータで内包表記の結果の受け取り方を変えられる
IO.inspect for x <- ~w{ cat dog }, do: { x, String.upcase(x)} # => [{"cat", "CAT"}, {"dog", "DOG"}]
IO.inspect for x <- ~w{ cat dog }, into: %{}, do: { x, String.upcase(x)} # => [{"cat", "CAT"}, {"dog", "DOG"}]
