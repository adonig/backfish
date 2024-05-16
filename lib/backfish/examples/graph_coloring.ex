defmodule Backfish.Examples.GraphColoring do
  use Backfish.ProblemDefinition

  def initial_state(args) do
    graph = Keyword.get(args, :graph, %{})
    colors = Keyword.get(args, :colors, 3)
    %{graph: graph, colors: colors, color_assignment: %{}}
  end

  def is_goal?(%{graph: graph, color_assignment: color_assignment}) do
    Enum.all?(Map.keys(graph), &Map.has_key?(color_assignment, &1))
  end

  def next_steps(%{graph: graph, colors: colors, color_assignment: color_assignment}) do
    node = next_node(graph, color_assignment)
    available_colors = Enum.to_list(1..colors)

    Enum.map(available_colors, fn color ->
      new_color_assignment = Map.put(color_assignment, node, color)
      %{graph: graph, colors: colors, color_assignment: new_color_assignment}
    end)
    |> Enum.filter(&valid_coloring?(&1))
  end

  defp next_node(graph, color_assignment) do
    Enum.find(Map.keys(graph), fn node -> not Map.has_key?(color_assignment, node) end)
  end

  defp valid_coloring?(%{graph: graph, color_assignment: color_assignment}) do
    Enum.all?(Map.keys(color_assignment), fn node ->
      neighbors = Map.get(graph, node, [])

      Enum.all?(neighbors, fn neighbor ->
        Map.get(color_assignment, neighbor) != Map.get(color_assignment, node)
      end)
    end)
  end
end
