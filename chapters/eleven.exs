#~を使う文法をシジルと呼ぶ

IO.inspect ~w[a b c d e]  #=> ["a", "b", "c", "d", "e"]
IO.inspect ~w[a b c d e]a #=> [:a, :b, :c, :d, :e]
