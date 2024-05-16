defmodule Backfish.Examples.HamiltonianPathTest do
  use ExUnit.Case, async: true

  alias Backfish.Examples.HamiltonianPath

  test "finds the Hamiltonian path in the graph" do
    graph = %{
      a: [:b, :c, :d],
      b: [:a, :c, :e],
      c: [:a, :b, :d, :e],
      d: [:a, :c, :e],
      e: [:b, :c, :d]
    }

    {:ok, solution} =
      Backfish.find_first_solution(HamiltonianPath,
        args: [
          graph: graph,
          start_node: :a
        ]
      )

    assert HamiltonianPath.is_goal?(solution)
  end
end
