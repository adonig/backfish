defmodule Backfish.ProblemDefinitionTest do
  use ExUnit.Case, async: true

  defmodule TestProblem do
    use Backfish.ProblemDefinition

    def initial_state(), do: 0
    def is_goal?(state, _path), do: state == 3
    def next_steps(state, _path), do: [state + 1]
  end

  test "problem definition works" do
    assert TestProblem.initial_state() == 0
    assert TestProblem.is_goal?(3, []) == true
    assert TestProblem.next_steps(2, []) == [3]
  end
end
