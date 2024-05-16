defmodule Backfish.Examples.SudokuTest do
  use ExUnit.Case, async: true

  alias Backfish.Examples.Sudoku

  test "solves a simple Sudoku puzzle" do
    board = [
      [5, 3, 0, 0, 7, 0, 0, 0, 0],
      [6, 0, 0, 1, 9, 5, 0, 0, 0],
      [0, 9, 8, 0, 0, 0, 0, 6, 0],
      [8, 0, 0, 0, 6, 0, 0, 0, 3],
      [4, 0, 0, 8, 0, 3, 0, 0, 1],
      [7, 0, 0, 0, 2, 0, 0, 0, 6],
      [0, 6, 0, 0, 0, 0, 2, 8, 0],
      [0, 0, 0, 4, 1, 9, 0, 0, 5],
      [0, 0, 0, 0, 8, 0, 0, 7, 9]
    ]

    {:ok, solution} = Backfish.find_first_solution(Sudoku, args: [board: board])
    assert Sudoku.is_goal?(solution)
  end

  test "solves a nearly complete Sudoku puzzle" do
    board = [
      [5, 3, 4, 6, 7, 8, 9, 1, 0],
      [6, 7, 2, 1, 9, 5, 3, 4, 8],
      [1, 9, 8, 3, 4, 2, 5, 6, 7],
      [8, 5, 9, 7, 6, 1, 4, 2, 3],
      [4, 2, 6, 8, 5, 3, 7, 9, 1],
      [7, 1, 3, 9, 2, 4, 8, 5, 6],
      [9, 6, 1, 5, 3, 7, 2, 8, 4],
      [2, 8, 7, 4, 1, 9, 6, 3, 5],
      [3, 4, 5, 2, 8, 6, 1, 7, 9]
    ]

    {:ok, solution} = Backfish.find_first_solution(Sudoku, args: [board: board])
    assert Sudoku.is_goal?(solution)
  end

  test "solves an empty Sudoku puzzle" do
    board = List.duplicate(List.duplicate(0, 9), 9)

    {:ok, solution} = Backfish.find_first_solution(Sudoku, args: [board: board])
    assert Sudoku.is_goal?(solution)
  end

  test "respects depth limit when solving Sudoku puzzle" do
    board = [
      [5, 3, 0, 0, 7, 0, 0, 0, 0],
      [6, 0, 0, 1, 9, 5, 0, 0, 0],
      [0, 9, 8, 0, 0, 0, 0, 6, 0],
      [8, 0, 0, 0, 6, 0, 0, 0, 3],
      [4, 0, 0, 8, 0, 3, 0, 0, 1],
      [7, 0, 0, 0, 2, 0, 0, 0, 6],
      [0, 6, 0, 0, 0, 0, 2, 8, 0],
      [0, 0, 0, 4, 1, 9, 0, 0, 5],
      [0, 0, 0, 0, 8, 0, 0, 7, 9]
    ]

    result =
      Backfish.find_first_solution(Sudoku,
        args: [board: board],
        depth_limit: 5
      )

    assert result == :error
  end

  test "finds all solutions for a Sudoku puzzle" do
    board = [
      [2, 9, 5, 7, 4, 3, 8, 6, 1],
      [4, 3, 1, 8, 6, 5, 9, 0, 0],
      [8, 7, 6, 1, 9, 2, 5, 4, 3],
      [3, 8, 7, 4, 5, 9, 2, 1, 6],
      [6, 1, 2, 3, 8, 7, 4, 9, 5],
      [5, 4, 9, 2, 1, 6, 7, 3, 8],
      [7, 6, 3, 5, 2, 4, 1, 8, 9],
      [9, 2, 8, 6, 7, 1, 3, 5, 4],
      [1, 5, 4, 9, 3, 8, 6, 0, 0]
    ]

    solutions = Backfish.find_all_solutions(Sudoku, args: [board: board])
    assert length(solutions) == 2
    assert Enum.all?(solutions, &Sudoku.is_goal?/1)
  end

  test "returns error for an unsolvable Sudoku puzzle" do
    board = [
      [5, 3, 0, 0, 7, 0, 0, 0, 0],
      [6, 0, 0, 1, 9, 5, 0, 0, 0],
      [0, 9, 8, 0, 0, 0, 0, 6, 0],
      [8, 0, 0, 0, 6, 0, 0, 0, 3],
      [4, 0, 0, 8, 0, 3, 0, 0, 1],
      [7, 0, 0, 0, 2, 0, 0, 0, 6],
      [0, 6, 0, 0, 0, 0, 2, 8, 0],
      [0, 0, 0, 4, 1, 9, 0, 0, 5],
      [0, 0, 0, 0, 8, 0, 0, 7, 7]
    ]

    result = Backfish.find_first_solution(Sudoku, args: [board: board])
    assert result == :error
  end
end
