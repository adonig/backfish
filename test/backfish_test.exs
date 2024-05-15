defmodule BackfishTest do
  use ExUnit.Case, async: true

  defmodule TestProblem do
    use Backfish.ProblemDefinition

    def initial_state, do: 0
    def is_goal?(state, _path), do: state == 3
    def next_steps(state, _path), do: [state + 1]
  end

  test "find_all_solutions finds all solutions" do
    solutions = Backfish.find_all_solutions(TestProblem)
    assert solutions == [[1, 2, 3]]
  end

  test "find_first_solution finds the first solution" do
    {:ok, solution} = Backfish.find_first_solution(TestProblem)
    assert solution == [1, 2, 3]
  end
end
