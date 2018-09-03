defmodule FibSolver do
  def fib(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:fib, n, client} ->
        send client, {:answer, n, fib_calc(n), self}
        fib(scheduler)
      {:shutdown} ->
        exit(:normal)
    end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)
end

defmodule Scheduler do
  def run(process_count, module, func, to_calculate) do
    (1..process_count)
    #process_countで指定した数だけmodule.func(self)を実行するprocessを生成する
    |> Enum.map(fn(_) -> spawn(module, func, [self]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      #初回もしくはqueue1つの処理を終えて準備のできたprocessからメッセージとPIDが来る
      {:ready, pid} when length(queue) > 0 ->
        [next|tail] = queue
        send pid, {:fib, next, self}
        schedule_processes(processes, tail, results)
      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          #ここに来た時点で積まれているqueueはない
          #他のprocessは仕事を続けているがこのPIDがする仕事はないのでprocessesから削除
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          #残りprocessesが1コ => 最後のプロセスが仕事を終えてsendしてきた
          #ただnでソートしてるだけ
          Enum.sort(results, fn {n1,_}, {n2,_} -> n1 <= n2 end)
        end
      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [{number, result}|results])
    end
  end
end

to_process = [37, 10, 4, 14, 3, 21]
Enum.each 1..10, fn process_count ->
  {time, result} = :timer.tc(
  Scheduler, :run,
  [process_count, FibSolver, :fib, to_process]
)
  if process_count == 1 do
    IO.inspect result
    IO.puts "\n #    time (s)"
  end
  :io.format "~2B    ~.2f~n", [process_count, time/1000000.0]
end
