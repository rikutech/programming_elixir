defmodule Main do
  def main do
    list = Enum.to_list 1..5
    IO.inspect Enum.map(list, &String.duplicate("*", &1))
    require Integer
    IO.inspect Enum.filter(list, &Integer.is_even/1)
    IO.inspect Enum.reject(list, &Integer.is_even/1)
    IO.inspect Enum.join(list)
  end
end
