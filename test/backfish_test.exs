defmodule BackfishTest do
  use ExUnit.Case, async: true

  defmodule TestProblem do
    use Backfish.ProblemDefinition

    def initial_state(args), do: Keyword.get(args, :start, 0)
    def is_goal?(state, _path), do: state == 3
    def next_steps(state, _path), do: [state + 1]
  end

  describe "find_all_solutions/2" do
    test "finds all solutions" do
      solutions = Backfish.find_all_solutions(TestProblem)
      assert solutions == [[1, 2, 3]]
    end

    test "passes args to initial_state/1" do
      solutions = Backfish.find_all_solutions(TestProblem, args: [start: 1])
      assert solutions == [[2, 3]]
    end
  end

  describe "find_first_solution/2" do
    test "finds the first solution" do
      {:ok, solution} = Backfish.find_first_solution(TestProblem)
      assert solution == [1, 2, 3]
    end

    test "passes args to initial_state/1" do
      {:ok, solution} = Backfish.find_first_solution(TestProblem, args: [start: 1])
      assert solution == [2, 3]
    end
  end
end
