defmodule Backfish.Examples.Sudoku do
  @moduledoc """
  An implementation of the Sudoku puzzle using the Backfish backtracking library.

  Sudoku is a logic-based combinatorial number-placement puzzle. The objective
  is to fill a 9x9 grid with digits so that each column, each row, and each of
  the nine 3x3 subgrids that compose the grid contain all of the digits from 1
  to 9.
  """

  use Backfish.ProblemDefinition

  @doc """
  Returns the initial state of the Sudoku puzzle.

  ## Parameters

    - `args`: A keyword list of arguments. Expects `:board` which is a 2D list
      representing the initial board configuration.

  ## Returns

    - A map representing the initial state, including the board and the board
      size.
  """
  @impl true
  def initial_state(args) do
    board = Keyword.get(args, :board, [])
    size = length(board)
    %{board: board, size: size}
  end

  @doc """
  Checks if the given state is a goal state.

  ## Parameters

    - `state`: The current state of the problem, which includes the board
      configuration and the board size.

  ## Returns

    - `true` if all cells in the board contain numbers from 1 to the board
      size, `false` otherwise.
  """
  @impl true
  def is_goal?(%{board: board, size: size}) do
    Enum.all?(for row <- board, cell <- row, do: cell in 1..size)
  end

  @doc """
  Generates the next possible states from the given state.

  ## Parameters

    - `state`: The current state of the problem, which includes the board
      configuration and the board size.

  ## Returns

    - A list of the next possible states, each including the new board
      configuration with one additional number placed.
  """
  @impl true
  def next_steps(%{board: board, size: size}) do
    case find_empty_cell(board) do
      nil ->
        []

      {row, col} ->
        for num <- 1..size, valid?(board, {row, col}, num) do
          update_board(board, {row, col}, num)
        end
        |> Enum.map(&%{board: &1, size: size})
    end
  end

  # Finds the first empty cell (with a value of 0) in the board.
  defp find_empty_cell(board) do
    Enum.find_value(Enum.with_index(board), fn {row, row_index} ->
      Enum.find_value(Enum.with_index(row), fn {cell, col_index} ->
        if cell == 0, do: {row_index, col_index}
      end)
    end)
  end

  # Checks if placing a number at the given position is valid.
  defp valid?(board, {row, col}, num) do
    valid_row?(board, row, num) and valid_col?(board, col, num) and
      valid_box?(board, {row, col}, num)
  end

  # Checks if placing a number in the given row is valid.
  defp valid_row?(board, row, num) do
    Enum.all?(board |> Enum.at(row), fn cell -> cell != num end)
  end

  # Checks if placing a number in the given column is valid.
  defp valid_col?(board, col, num) do
    Enum.all?(board, fn row -> Enum.at(row, col) != num end)
  end

  # Checks if placing a number in the 3x3 box is valid.
  defp valid_box?(board, {row, col}, num) do
    box_row_start = div(row, 3) * 3
    box_col_start = div(col, 3) * 3

    for(
      r <- box_row_start..(box_row_start + 2),
      c <- box_col_start..(box_col_start + 2),
      do: Enum.at(Enum.at(board, r), c)
    )
    |> Enum.all?(&(&1 != num))
  end

  # Updates the board with the given number at the specified position.
  defp update_board(board, {row, col}, num) do
    List.update_at(board, row, fn row_list ->
      List.update_at(row_list, col, fn _ -> num end)
    end)
  end
end
