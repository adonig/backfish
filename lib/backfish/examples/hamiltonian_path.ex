defmodule Backfish.Examples.HamiltonianPath do
  @moduledoc """
  An implementation of the Hamiltonian path problem using the Backfish
  backtracking library.

  The Hamiltonian path problem involves finding a path in an undirected or
  directed graph that visits each vertex exactly once.
  """

  use Backfish.ProblemDefinition

  @doc """
  Returns the initial state of the Hamiltonian path problem.

  ## Parameters

    - `args`: A keyword list of arguments. Expects `:graph`, which is a map
      representing the graph where keys are nodes and values are lists of
      adjacent nodes, and `:start_node`, which is the starting node for the
      path.

  ## Returns

    - A map representing the initial state, including the graph, the initial
      path with the starting node, and a set of visited nodes.
  """
  @impl true
  def initial_state(args) do
    graph = Keyword.get(args, :graph, %{})
    start_node = Keyword.get(args, :start_node, nil)
    %{graph: graph, path: [start_node], visited: MapSet.new([start_node])}
  end

  @doc """
  Checks if the given state is a goal state.

  ## Parameters

    - `state`: The current state of the problem, which includes the graph, the
      path, and the set of visited nodes.

  ## Returns

    - `true` if the number of visited nodes equals the number of nodes in the
      graph, `false` otherwise.
  """
  @impl true
  def is_goal?(%{graph: graph, path: _path, visited: visited}) do
    MapSet.size(visited) == map_size(graph)
  end

  @doc """
  Generates the next possible states from the given state.

  ## Parameters

    - `state`: The current state of the problem, which includes the graph, the
      path, and the set of visited nodes.

  ## Returns

    - A list of the next possible states, each including a new path with an
      additional node visited.
  """
  @impl true
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
