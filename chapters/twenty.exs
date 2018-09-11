defmodule My do
  defmacro macro(code) do
    quote do
      IO.inspect(unquote(code))
    end
  end

  defmacro if(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(else_clause)
        _ -> unquote(do_clause)
      end
    end
  end

  defmacro unless(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(do_clause)
        _ -> unquote(else_clause)
      end
    end
  end

  defmacro mydef(name) do
    #bindingを使うと遅延評価できる
    quote bind_quoted: [name: name] do
      def unquote(name)(), do: unquote(name)
    end
  end
end

defmodule Times do
  defmacro times_n(n) do
    quote do
      def unquote(:"times_#{n}")(m) do
       m * unquote(n)
      end
    end
  end
end

#マクロは自分自身のスコープとquoteしたマクロのボディのスコープを持つ
#→使用元のスコープを汚すことはない(この挙動をオフにする方法もあるらしい。。。)
defmodule Scope do
  defmacro update_local(val) do
    local = "some value"
    result = quote do
      local = unquote(val)
      IO.puts "End of macro body, local = #{local}"
    end
    IO.puts "In macro definition, local = #{local}"
    result
  end
end

defmodule Test do
  require My
  require Times
  require Scope

  My.macro(IO.puts("Hello"))
  Times.times_n(3)
  [:fred, :bert] |> Enum.each(&My.mydef(&1))
  local = 123
  Scope.update_local("cat")
  IO.puts "On return, local = #{local}"
end
