#5.1

#無名関数の定義
sum = fn (a,b) -> a + b end
IO.inspect sum
IO.puts sum.(1,2) # => 3

#関数定義時の仮引数を囲むカッコは省略可能
f1 = fn a, b -> a * b end
IO.puts f1.(10,11) # => 110

#仮引数の定義にもパターンマッチが活用可能(すごい)
swap = fn {a,b} -> {b,a} end
IO.inspect swap.({6,8}) # => {8,6}

list_concat = fn a, b -> a ++ b end
IO.inspect list_concat.([:a, :b], [:c, :d]) # => [:a, :b, :c, :d]

sum = fn a,b,c -> a + b + c end
IO.puts sum.(1,2,3) # => 6

pair_tuple_to_list = fn {a, b} -> [a,b] end
IO.inspect pair_tuple_to_list.({1000, 2000})

#5.2

#パターンマッチによって関数の実行内容を変更(Haskellに近いが、引数の数は揃える必要がある)
handle_open = fn
  {:ok, file} -> "Read data: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
end

IO.puts handle_open.(File.open('./five.exs'))
IO.puts handle_open.(File.open('./nonexistent'))

#練習問題 Functions - 2
three_args = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end 
IO.puts three_args.(0,0,1) #=> FizzBuzz
IO.puts three_args.(0,1,1) #=> Fizz
IO.puts three_args.(1,0,1) #=> Buzz
IO.puts three_args.(1,1,1) #=> 1

#練習問題 Functions - 3

fizzbuzz = fn n -> three_args.(rem(n, 3), rem(n, 5), n) end
IO.puts fizzbuzz.(10)
IO.puts fizzbuzz.(11)
IO.puts fizzbuzz.(12)
IO.puts fizzbuzz.(13)
IO.puts fizzbuzz.(14)
IO.puts fizzbuzz.(15)
IO.puts fizzbuzz.(16)

#入れ子の関数 クロージャは変数の束縛を持ち回るので、内側の関数が定義されたときに外側のスコープを受け継ぐ
greeter = fn name -> (fn -> "Hello #{name}" end) end
dave_greeter = greeter.("Dave")
IO.puts dave_greeter.() # => "Hello Dave"

#入れ子を活用した部分適用
add_n = fn n -> (fn other -> n + other end) end
add_two = add_n.(2)
add_five = add_n.(5)

IO.puts add_two.(3) #=> 5
IO.puts add_five.(7) #=> 12

#練習問題 Functions - 4
prefix = fn str -> (fn other -> "#{str} #{other}" end) end
mrs = prefix.("Mrs")
IO.puts mrs.("Smith") #=> "Mrs Smith"
IO.puts prefix.("Elixir").("Rocks") #=> "Elixir Rocks"

#5.4


