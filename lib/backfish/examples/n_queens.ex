defmodule Backfish.Examples.NQueens do
  @moduledoc """
  An implementation of the N-Queens problem using the Backfish backtracking
  library.

  The N-Queens problem involves placing N chess queens on an NxN chessboard so
  that no two queens threaten each other. Thus, a solution requires that no
  two queens share the same row, column, or diagonal.
  """

  use Backfish.ProblemDefinition

  @default_size 8

  @doc """
  Returns the initial state of the N-Queens problem.

  ## Parameters

    - `args`: A keyword list of arguments. Expects `:size` which represents
      the size of the board (default is 8).

  ## Returns

    - A map representing the initial state, including an empty board and the
      board size.
  """
  @impl true
  def initial_state(args) do
    size = Keyword.get(args, :size, @default_size)
    %{board: [], size: size}
  end

  @doc """
  Checks if the given state is a goal state.

  ## Parameters

    - `state`: The current state of the problem, which includes the board
      configuration and the board size.

  ## Returns

    - `true` if the number of queens on the board equals the size of the board,
      `false` otherwise.
  """
  @impl true
  def is_goal?(%{board: board, size: size}) do
    length(board) == size
  end

  @doc """
  Generates the next possible states from the given state.

  ## Parameters

    - `state`: The current state of the problem, which includes the board
      configuration and the board size.

  ## Returns

    - A list of the next possible states, each including the new board
      configuration with one additional queen placed.
  """
  @impl true
  def next_steps(%{board: board, size: size}) do
    row = length(board) + 1

    1..size
    |> Enum.filter(fn col -> valid_position?(board, {row, col}) end)
    |> Enum.map(fn col -> %{board: [{row, col} | board], size: size} end)
  end

  # Checks if placing a queen at the given position is valid.
  defp valid_position?(board, {row, col}) do
    Enum.all?(board, fn {r, c} ->
      c != col && abs(c - col) != abs(r - row)
    end)
  end
end
