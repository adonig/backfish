defmodule BackfishTest do
  use ExUnit.Case, async: true

  defmodule TestProblem do
    use Backfish.ProblemDefinition

    def initial_state(args), do: Keyword.get(args, :start, 0)
    def is_goal?(state), do: state == 3
    def next_steps(state), do: [state + 1]
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

    test "setting depth_limit prevents nontermination" do
      solutions =
        Backfish.find_all_solutions(TestProblem,
          args: [start: 4],
          depth_limit: 15
        )

      assert solutions == []
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

    test "setting depth_limit prevents nontermination" do
      :error =
        Backfish.find_first_solution(TestProblem,
          args: [start: 4],
          depth_limit: 15
        )
    end
  end
end
