defmodule Backfish do
  @doc """
  Finds all solutions to the given problem.
  """
  def find_all_solutions(problem_module) do
    initial_state = problem_module.initial_state()
    solve_all(problem_module, initial_state, [])
  end

  @doc """
  Finds the first valid solution to the given problem.
  """
  def find_first_solution(problem_module) do
    initial_state = problem_module.initial_state()
    solve_first(problem_module, initial_state, [])
  end

  defp solve_all(problem_module, state, path) do
    if problem_module.is_goal?(state, path) do
      [Enum.reverse(path)]
    else
      problem_module.next_steps(state, path)
      |> Enum.flat_map(fn next_state ->
        solve_all(problem_module, next_state, [next_state | path])
      end)
    end
  end

  defp solve_first(problem_module, state, path) do
    if problem_module.is_goal?(state, path) do
      {:ok, Enum.reverse(path)}
    else
      problem_module.next_steps(state, path)
      |> Enum.find_value(fn next_state ->
        case solve_first(problem_module, next_state, [next_state | path]) do
          {:ok, solution} -> {:ok, solution}
          :error -> nil
        end
      end) || :error
    end
  end
end
