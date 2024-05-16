defmodule Backfish.Examples.HamiltonianPath do
  use Backfish.ProblemDefinition

  def initial_state(args) do
    graph = Keyword.get(args, :graph, %{})
    start_node = Keyword.get(args, :start_node, nil)
    %{graph: graph, path: [start_node], visited: MapSet.new([start_node])}
  end

  def is_goal?(%{graph: graph, path: _path, visited: visited}) do
    MapSet.size(visited) == map_size(graph)
  end

  def next_steps(%{graph: graph, path: path, visited: visited}) do
    current_node = hd(path)
    neighbors = Map.get(graph, current_node, [])

    neighbors
    |> Enum.filter(&(!MapSet.member?(visited, &1)))
    |> Enum.map(fn neighbor ->
      %{graph: graph, path: [neighbor | path], visited: MapSet.put(visited, neighbor)}
    end)
  end
end
