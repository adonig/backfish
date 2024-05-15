defmodule Backfish.Examples.NQueensTest do
  use ExUnit.Case, async: true

  alias Backfish.Examples.NQueens

  test "finds all solutions for the 8 queens problem" do
    solutions = Backfish.find_all_solutions(NQueens, args: [size: 8])
    assert length(solutions) == 92
  end

  test "finds a solution for the 8 queens problem" do
    {:ok, solution} = Backfish.find_first_solution(NQueens, args: [size: 8])
    assert length(solution) == 8
  end

  test "finds all solutions for the 4 queens problem" do
    solutions = Backfish.find_all_solutions(NQueens, args: [size: 4])
    assert length(solutions) == 2
  end

  test "finds a solution for the 4 queens problem" do
    {:ok, solution} = Backfish.find_first_solution(NQueens, args: [size: 4])
    assert length(solution) == 4
  end

  test "cannot find solutions for the 3 queens problem" do
    solutions = Backfish.find_all_solutions(NQueens, args: [size: 3])
    assert length(solutions) == 0
  end

  test "cannot find a solution for the 3 queens problem" do
    :error = Backfish.find_first_solution(NQueens, args: [size: 3])
  end
end
