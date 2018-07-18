defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true
end

defmodule Customer do
  defstruct name: "", company: ""
end

defmodule BugReport do
  defstruct owner: %Customer{}, details: "", severity: 1
end

defmodule Main do
  def main do
    report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"}, details: "broken"}
    IO.inspect report
    IO.inspect put_in(report.owner.company, "PragProg")
  end

  def map_set do
    set1 = Enum.into 1..5, MapSet.new
    MapSet.member? set1, 3 # => true
    set2 = Enum.into 3..8, MapSet.new
    MapSet.union set1, set2
    MapSet.difference set1, set2
    MapSet
  end
end

