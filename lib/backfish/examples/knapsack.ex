defmodule Backfish.Examples.Knapsack do
  @moduledoc """
  An implementation of the knapsack problem using the Backfish backtracking
  library.

  The knapsack problem involves selecting a subset of items, each with a weight
  and a value, to include in a knapsack so that the total weight does not
  exceed the capacity of the knapsack and the total value is maximized.
  """

  use Backfish.ProblemDefinition

  @doc """
  Returns the initial state of the knapsack problem.

  ## Parameters

    - `args`: A keyword list of arguments. Expects `:items`, which is a list of
      tuples representing the items (each tuple contains a value and a weight),
      and `:capacity`, which is the capacity of the knapsack.

  ## Returns

    - A map representing the initial state, including the items, capacity,
      current weight, current value, and a list indicating which items are
      included in the knapsack.
  """
  @impl true
  def initial_state(args) do
    items = Keyword.get(args, :items, [])
    capacity = Keyword.get(args, :capacity, 0)

    %{
      items: items,
      capacity: capacity,
      current_weight: 0,
      current_value: 0,
      included: []
    }
  end

  @doc """
  Checks if the given state is a goal state.

  ## Parameters

    - `state`: The current state of the problem, which includes the items and
      the list of included items.

  ## Returns

    - `true` if the number of included items equals the total number of items,
      `false` otherwise.
  """
  @impl true
  def is_goal?(%{items: items, included: included}) do
    Enum.count(included) == Enum.count(items)
  end

  @doc """
  Generates the next possible states from the given state.

  ## Parameters

    - `state`: The current state of the problem, which includes the items,
      capacity, current weight, current value, and the list of included items.

  ## Returns

    - A list of the next possible states, each including a new item either
      included or excluded.
  """
  @impl true
  def next_steps(%{
        items: items,
        capacity: capacity,
        current_weight: current_weight,
        current_value: current_value,
        included: included
      }) do
    next_index = Enum.count(included)

    if next_index >= Enum.count(items) do
      []
    else
      item = Enum.at(items, next_index)

      [
        %{
          items: items,
          capacity: capacity,
          current_weight: current_weight,
          current_value: current_value,
          included: [false | included]
        },
        %{
          items: items,
          capacity: capacity,
          current_weight: current_weight + elem(item, 1),
          current_value: current_value + elem(item, 0),
          included: [true | included]
        }
      ]
      |> Enum.filter(fn state -> state.current_weight <= state.capacity end)
    end
  end
end
