defmodule Backfish do
  @doc """
  Finds all solutions to the given problem.
  """
  def find_all_solutions(problem_module, opts \\ []) do
    args = Keyword.get(opts, :args, [])
    depth_limit = Keyword.get(opts, :depth_limit)
    initial_state = problem_module.initial_state(args)
    solve_all(problem_module, initial_state, [], depth_limit, 0)
  end

  @doc """
  Finds the first valid solution to the given problem.
  """
  def find_first_solution(problem_module, opts \\ []) do
    args = Keyword.get(opts, :args, [])
    depth_limit = Keyword.get(opts, :depth_limit)
    initial_state = problem_module.initial_state(args)
    solve_first(problem_module, initial_state, [], depth_limit, 0)
  end

  defp solve_all(_, _, _, depth_limit, depth) when depth >= depth_limit do
    []
  end

  defp solve_all(problem_module, state, path, depth_limit, depth) do
    if problem_module.is_goal?(state) do
      [state]
    else
      problem_module.next_steps(state)
      |> Enum.flat_map(fn next_state ->
        solve_all(
          problem_module,
          next_state,
          [next_state | path],
          depth_limit,
          depth + 1
        )
      end)
    end
  end

  defp solve_first(_, _, _, depth_limit, depth) when depth >= depth_limit do
    :error
  end

  defp solve_first(problem_module, state, path, depth_limit, depth) do
    if problem_module.is_goal?(state) do
      {:ok, state}
    else
      problem_module.next_steps(state)
      |> Enum.find_value(fn next_state ->
        case solve_first(
               problem_module,
               next_state,
               [next_state | path],
               depth_limit,
               depth + 1
             ) do
          {:ok, solution} -> {:ok, solution}
          :error -> nil
        end
      end) || :error
    end
  end
end
