#タプル:順序持ちのコレクション
{:ok, 11, "next"}

#タプルにもパターンマッチが使える
{status, count, action} = {:ok, 42, "next"}
IO.puts status # => :ok
IO.puts count # => 42
IO.puts action # => "next"

#リスト用演算子
IO.inspect [1,2,3] ++ [4,5,6] # => [1,2,3,4,5,6]
IO.inspect [1,2,3,4] -- [2,4] # => [1,3]
IO.puts 1 in [1,2,3,4] # => true
IO.puts "wombat" in [1,2,3,4] # => false

#キーワードリスト　タプルのリストのシンタックスシュガー
IO.inspect [name: "Dave", city: "Dallas", likes: "Programming"]



