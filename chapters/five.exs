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

