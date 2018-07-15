# 5.1

# 無名関数の定義
sum = fn a, b -> a + b end
IO.inspect(sum)
# => 3
IO.puts(sum.(1, 2))

# 関数定義時の仮引数を囲むカッコは省略可能
f1 = fn a, b -> a * b end
# => 110
IO.puts(f1.(10, 11))

# 仮引数の定義にもパターンマッチが活用可能(すごい)
swap = fn {a, b} -> {b, a} end
# => {8,6}
IO.inspect(swap.({6, 8}))

list_concat = fn a, b -> a ++ b end
# => [:a, :b, :c, :d]
IO.inspect(list_concat.([:a, :b], [:c, :d]))

sum = fn a, b, c -> a + b + c end
# => 6
IO.puts(sum.(1, 2, 3))

pair_tuple_to_list = fn {a, b} -> [a, b] end
IO.inspect(pair_tuple_to_list.({1000, 2000}))

# 5.2

# パターンマッチによって関数の実行内容を変更(Haskellに近いが、引数の数は揃える必要がある)
handle_open = fn
  {:ok, file} -> "Read data: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
end

IO.puts(handle_open.(File.open('./five.exs')))
IO.puts(handle_open.(File.open('./nonexistent')))

# 練習問題 Functions - 2
three_args = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end

# => FizzBuzz
IO.puts(three_args.(0, 0, 1))
# => Fizz
IO.puts(three_args.(0, 1, 1))
# => Buzz
IO.puts(three_args.(1, 0, 1))
# => 1
IO.puts(three_args.(1, 1, 1))

# 練習問題 Functions - 3

fizzbuzz = fn n -> three_args.(rem(n, 3), rem(n, 5), n) end
IO.puts(fizzbuzz.(10))
IO.puts(fizzbuzz.(11))
IO.puts(fizzbuzz.(12))
IO.puts(fizzbuzz.(13))
IO.puts(fizzbuzz.(14))
IO.puts(fizzbuzz.(15))
IO.puts(fizzbuzz.(16))

# 入れ子の関数 クロージャは変数の束縛を持ち回るので、内側の関数が定義されたときに外側のスコープを受け継ぐ
greeter = fn name -> fn -> "Hello #{name}" end end
dave_greeter = greeter.("Dave")
# => "Hello Dave"
IO.puts(dave_greeter.())

# 入れ子を活用した部分適用
add_n = fn n -> fn other -> n + other end end
add_two = add_n.(2)
add_five = add_n.(5)

# => 5
IO.puts(add_two.(3))
# => 12
IO.puts(add_five.(7))

# 練習問題 Functions - 4
prefix = fn str -> fn other -> "#{str} #{other}" end end
mrs = prefix.("Mrs")
# => "Mrs Smith"
IO.puts(mrs.("Smith"))
# => "Elixir Rocks"
IO.puts(prefix.("Elixir").("Rocks"))

# 5.4

# 関数は第一級オブジェクトなので引数として渡すことも可能
times_2 = fn n -> n * 2 end
apply = fn fun, value -> fun.(value) end
# =>20
IO.puts(apply.(times_2, 10))

list = [1, 3, 5, 7, 9]

IO.inspect(Enum.map(list, fn elem -> elem * elem end))


#ピン演算子(^)で固定した値はパターンで使用できる
defmodule Greeter do
  def for(name, greeting) do
    fn
      ^name -> "#{greeting} #{name}"
      _ -> "I don't know you"
    end
  end
end

mr_valim = Greeter.for("Jose", "Oi!")
IO.puts mr_valim.("Jose")
IO.puts mr_valim.("dave")

#&記法 swiftの$のようなもの
add_one = &(&1 + 1)
IO.puts add_one.(44) #=> 45

square = &(&1 * &1)
IO.puts square.(8) #=> 64

#無名関数がただのラッパーであれば、無名関数を取り除いて最適化してくれる(賢い！)
IO.inspect rnd = &(Float.round(&1, &2))
#=> &Float.round/2
#引数の順番は同じである必要がある
IO.inspect rnd = &(Float.round(&2, &1))
#=> Function<17.9604694 in file:five.exs>

#既に存在する関数の名前とパラメータの数を渡すと、それを呼び出す無名関数を返す
IO.inspect l = &length/1
#=> &:erlang.length/1
IO.puts l.([1,2,3,3,3,3]) #=>6

# 練習問題 Functions - 5
IO.inspect Enum.map [1,2,3,4], fn x -> x + 2 end
IO.inspect Enum.map [1,2,3,4], &(&1 + 2)
Enum.each [1,2,3,4], fn x -> IO.inspect x end
Enum.each [1,2,3,4], &(IO.inspect &1)
