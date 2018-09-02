defmodule SpawnBasic do
  def greet do
    IO.puts "Hello"
  end
end

defmodule Spawn2 do
  def greet do
    receive do
      {sender, msg} -> send sender, {:ok, "Hello, #{msg}"}
    end
  end
end

defmodule Spawn4 do
  def greet do
    receive do
      {sender, msg} -> send sender, {:ok, "Hello, #{msg}"}
      greet()
    end
  end
end

# greetを実行するプロセスを生成する
# pid = spawn(Spawn1, :greet, []) #=> PID<0.119.0>

# greetはreceive節でsender(送信元)とmsgを受け取り、senderに:okとmessageのタプルを返す
# send pid, {self, "World!"} #=> {#PID<0.101.0>, "World!"}

#receiveで受け取って出力
# receive do
#   {:ok, message} -> IO.puts message
# end


defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> send next_pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce(1..n, self,
      fn(_, send_to) ->
        spawn(Chain, :counter, [send_to])
      end)
    send last, 0

    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

defmodule UniqueToken do
  import :timer, only: [sleep: 1]
  def process do
    receive do
      {sender, token} -> send sender, token
    end
  end

  #processを順番に処理したければ都度receiveする必要がある 以下はpid1とpid2の順序は保証されない
  def run do
    pid1 = spawn(UniqueToken, :process, [])
    pid2 = spawn(UniqueToken, :process, [])
    send pid1, {self, "token1"}
    send pid2, {self, "token2"}
    receive do
      token -> IO.puts token
    end
  end
end
