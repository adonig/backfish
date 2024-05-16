defmodule Backfish.Examples.KnapsackTest do
  use ExUnit.Case, async: true

  alias Backfish.Examples.Knapsack

  test "solves the knapsack problem" do
    # {value, weight}
    items = [{60, 10}, {100, 20}, {120, 30}]
    capacity = 50

    solutions =
      Backfish.find_all_solutions(Knapsack, args: [items: items, capacity: capacity])
      |> Enum.to_list()

    # Find the solution with the maximum value
    best_solution = Enum.max_by(solutions, fn solution -> solution.current_value end)

    assert best_solution.current_value == 220
    assert best_solution.current_weight == 50
  end
end
