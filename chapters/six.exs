#6.2
#Elixirでは有名関数はmoduleの中でしか定義できない
defmodule Times do
  def double(n) do
    n * 2
  end
  #do end構文はdo:のシンタックスシュガーでしかない
  def triple(n), do: n * 3

  def quadruple(n), do: double(double(n))
end

defmodule Factorial do
  def of(0), do: 1
  def of(n) when n > 0, do: n * of(n-1)
end

defmodule MyMath do
  def sum(0), do: 0
  def sum(n), do: n + sum(n-1)
  def gcd(x,0), do: x
  def gcd(x, y), do: gcd(y, rem(x,y))
end

#6.4 ガード節
#パターンマッチだけでなく、guard節を使ってwhenでマッチさせることもできる
#(動的言語でここまでできるの衝撃すぎる。。。)
defmodule Guard do
  def what_is(x) when is_number(x) do
    IO.puts "#{x} is a number"
  end

  def what_is(x) when is_list(x) do
    IO.puts "#{inspect(x)} is a list"
  end

  def what_is(x) when is_atom(x) do
    IO.puts "#{x} is an atom"
  end
end

#デフォルト引数は \\ で指定
defmodule Example do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end
end


#レンジの先頭と終端を足して2で割る
#actualと↑の値を比較
#when actualより大きい do: レンジの
defmodule Chop do
  def guess(actual, a..b) when a <= actual and actual <= b do
    target = div(a+b, 2)
    IO.puts "Is it #{target}?"
    guess_num(actual, target, a..b)
  end

  defp guess_num(actual, target, a.._) when actual < target do
    guess(actual, a..target - 1)
  end
  defp guess_num(actual, target, _..b) when actual > target do
    guess(actual, target + 1..b)
  end
  defp guess_num(actual, target, _) when actual == target, do: IO.puts actual
end

#6.7
#パイプ演算子は結果を次の関数の第一引数として渡す(unixのフィルタの考え方が視覚化されているようだ…美しい)
IO.inspect (1..10) |> Enum.map(&(&1*&1)) |> Enum.filter(&(&1 < 40))

#importもスコープ対象
defmodule ImportExample do
  def func1 do
    List.flatten [1,[2,3],4]
  end
  def func2 do
    import List, only: [flatten: 1]
    flatten [5,[6,7],8]
  end
end

#moduleのトップレベルにだけ@nameで宣言できる 同じ属性に何度も設定可能 定数として使うことが多い
defmodule Attribute do
  @attr "one"
  def first, do: @attr
  @attr "two"
  def second, do: @attr
end

#6.10
#モジュールの名前はただのアトムに過ぎない(Elixir.というprefixがつく)
:"Elixir.IO".puts 123
