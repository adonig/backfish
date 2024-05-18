defmodule Backfish.Examples.GraphColoring do
  @moduledoc """
  An implementation of the graph coloring problem using the Backfish backtracking
  library.

  The graph coloring problem involves assigning colors to the vertices of a graph
  such that no two adjacent vertices share the same color. The objective is to
  use the minimum number of colors.
  """

  use Backfish.ProblemDefinition

  @doc """
  Returns the initial state of the graph coloring problem.

  ## Parameters

    - `args`: A keyword list of arguments. Expects `:graph`, which is a map
      representing the graph where keys are nodes and values are lists of
      adjacent nodes, and `:colors`, which is the number of colors available
      (default is 3).

  ## Returns

    - A map representing the initial state, including the graph, the number of
      colors, and an empty color assignment.
  """
  @impl true
  def initial_state(args) do
    graph = Keyword.get(args, :graph, %{})
    colors = Keyword.get(args, :colors, 3)
    %{graph: graph, colors: colors, color_assignment: %{}}
  end

  @doc """
  Checks if the given state is a goal state.

  ## Parameters

    - `state`: The current state of the problem, which includes the graph and
      the color assignment.

  ## Returns

    - `true` if all nodes in the graph have been assigned a color, `false`
      otherwise.
  """
  @impl true
  def is_goal?(%{graph: graph, color_assignment: color_assignment}) do
    Enum.all?(Map.keys(graph), &Map.has_key?(color_assignment, &1))
  end

  @doc """
  Generates the next possible states from the given state.

  ## Parameters

    - `state`: The current state of the problem, which includes the graph, the
      number of colors, and the color assignment.

  ## Returns

    - A list of the next possible states, each including a new color assignment
      with one additional node colored.
  """
  @impl true
  def next_steps(%{graph: graph, colors: colors, color_assignment: color_assignment}) do
    node = next_node(graph, color_assignment)
    available_colors = Enum.to_list(1..colors)

    Enum.map(available_colors, fn color ->
      new_color_assignment = Map.put(color_assignment, node, color)
      %{graph: graph, colors: colors, color_assignment: new_color_assignment}
    end)
    |> Enum.filter(&valid_coloring?(&1))
  end

  # Finds the next uncolored node in the graph.
  defp next_node(graph, color_assignment) do
    Enum.find(Map.keys(graph), fn node -> not Map.has_key?(color_assignment, node) end)
  end

  # Checks if the current color assignment is valid.
  defp valid_coloring?(%{graph: graph, color_assignment: color_assignment}) do
    Enum.all?(Map.keys(color_assignment), fn node ->
      neighbors = Map.get(graph, node, [])

      Enum.all?(neighbors, fn neighbor ->
        Map.get(color_assignment, neighbor) != Map.get(color_assignment, node)
      end)
    end)
  end
end
