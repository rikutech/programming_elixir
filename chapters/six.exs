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
  def of(n), do: n * of(n-1)
end

defmodule MyMath do
  def sum(0), do: 0
  def sum(n), do: n + sum(n-1)
  def gcd(x,0), do: x
  def gcd(x, y), do: gcd(y, rem(x,y))
end

