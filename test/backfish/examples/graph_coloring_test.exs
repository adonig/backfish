defmodule Backfish.Examples.GraphColoringTest do
  use ExUnit.Case, async: true

  alias Backfish.Examples.GraphColoring

  test "solves the graph coloring problem" do
    graph = %{
      a: [:b, :c],
      b: [:a, :c, :d],
      c: [:a, :b, :d],
      d: [:b, :c]
    }

    {:ok, solution} = Backfish.find_first_solution(GraphColoring, args: [graph: graph, colors: 3])
    assert GraphColoring.is_goal?(solution)
  end
end
