defmodule Backfish do
  @moduledoc """
  Backfish is a flexible and powerful backtracking library for Elixir, designed
  to solve combinatorial and constraint satisfaction problems.
  """

  @doc """
  Finds all solutions to the given problem.

  ## Parameters

    - `problem_module`: The module implementing the problem definition using
      `Backfish.ProblemDefinition`.
    - `opts`: Optional keyword list of options. Supports:
      - `:args`: Arguments to pass to the `initial_state/1` function of the
        problem module.
      - `:depth_limit`: Optional limit on the depth of the search.

  ## Examples

      iex> opts = [args: [size: 8]]
      iex> Backfish.find_all_solutions(Backfish.Examples.NQueens, opts)
      [solution1, solution2, ...]

  """
  def find_all_solutions(problem_module, opts \\ []) do
    args = Keyword.get(opts, :args, [])
    depth_limit = Keyword.get(opts, :depth_limit, :infinity)
    initial_state = problem_module.initial_state(args)
    solve_all(problem_module, initial_state, depth_limit, 0)
  end

  @doc """
  Finds the first valid solution to the given problem.

  ## Parameters

    - `problem_module`: The module implementing the problem definition using
      `Backfish.ProblemDefinition`.
    - `opts`: Optional keyword list of options. Supports:
      - `:args`: Arguments to pass to the `initial_state/1` function of the
        problem module.
      - `:depth_limit`: Optional limit on the depth of the search.

  ## Examples

      iex> opts = [args: [size: 8]]
      iex> {:ok, solution} = Backfish.find_first_solution(Backfish.Examples.NQueens, opts)
      {:ok, solution}

  """
  def find_first_solution(problem_module, opts \\ []) do
    args = Keyword.get(opts, :args, [])
    depth_limit = Keyword.get(opts, :depth_limit, :infinity)
    initial_state = problem_module.initial_state(args)
    solve_first(problem_module, initial_state, depth_limit, 0)
  end

  defp solve_all(_, _, depth_limit, depth) when depth >= depth_limit,
    do: []

  defp solve_all(problem_module, state, depth_limit, depth) do
    if problem_module.is_goal?(state) do
      [state]
    else
      problem_module.next_steps(state)
      |> Enum.flat_map(fn next_state ->
        solve_all(problem_module, next_state, depth_limit, depth + 1)
      end)
    end
  end

  defp solve_first(_, _, depth_limit, depth) when depth >= depth_limit,
    do: :error

  defp solve_first(problem_module, state, depth_limit, depth) do
    if problem_module.is_goal?(state) do
      {:ok, state}
    else
      problem_module.next_steps(state)
      |> Enum.find_value(:error, fn next_state ->
        case solve_first(problem_module, next_state, depth_limit, depth + 1) do
          {:ok, solution} -> {:ok, solution}
          :error -> nil
        end
      end)
    end
  end
end
