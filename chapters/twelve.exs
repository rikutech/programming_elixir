defmodule Main do
  def main do
    IO.puts if 1 == 1, do: "true part", else: "false part"
    IO.puts unless 1 == 1, do: "true part", else: "false part"
  end
end

