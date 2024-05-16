defmodule Backfish.Examples.Knapsack do
  use Backfish.ProblemDefinition

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

  def is_goal?(%{items: items, included: included}) do
    Enum.count(included) == Enum.count(items)
  end

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
