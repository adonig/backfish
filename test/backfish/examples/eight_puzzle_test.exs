defmodule Backfish.Examples.EightPuzzleTest do
  use ExUnit.Case, async: true

  alias Backfish.Examples.EightPuzzle

  test "solves the 8-puzzle problem" do
    board = [
      [1, 2, 3],
      [4, 5, 6],
      [0, 7, 8]
    ]

    {:ok, solution} = Backfish.find_first_solution(EightPuzzle, args: [board: board])
    assert EightPuzzle.is_goal?(solution)
  end
end
