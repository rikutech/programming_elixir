defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true
end

defmodule Customer do
  defstruct name: "", company: ""
end

defmodule BugReport do
  defstruct owner: %Customer{}, details: "", severity: 1
end
