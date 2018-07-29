defmodule SpawnBasic do
  def greet do
    IO.puts "Hello"
  end
end

defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} -> send sender, {:ok, "Hello, #{msg}"}
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
