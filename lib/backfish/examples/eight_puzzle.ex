defmodule Backfish.Examples.EightPuzzle do
  @moduledoc """
  An implementation of the 8-puzzle problem using the Backfish backtracking
  library.

  The 8-puzzle consists of a 3x3 grid with 8 numbered tiles and one empty
  space. The goal is to move the tiles around to achieve a specific end
  configuration.
  """

  use Backfish.ProblemDefinition

  @goal_state [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 0]
  ]

  @doc """
  Returns the initial state of the 8-puzzle problem.

  ## Parameters

    - `args`: A keyword list of arguments. Expects `:board` which is a 2D list
      representing the initial board configuration.

  ## Returns

    - A map representing the initial state, including the board and a set of
      visited states.
  """
  @impl true
  def initial_state(args) do
    board = Keyword.get(args, :board, [])
    %{board: board, visited: MapSet.new([board])}
  end

  @doc """
  Checks if the given state is the goal state.

  ## Parameters

    - `state`: The current state of the problem, which includes the board
      configuration.

  ## Returns

    - `true` if the board is in the goal configuration, `false` otherwise.
  """
  @impl true
  def is_goal?(%{board: board}) do
    board == @goal_state
  end

  @doc """
  Generates the next possible states from the given state.

  ## Parameters

    - `state`: The current state of the problem, which includes the board
      configuration and the set of visited states.

  ## Returns

    - A list of the next possible states, each including the new board
      configuration and updated visited states.
  """
  @impl true
  def next_steps(%{board: board, visited: visited}) do
    case find_empty_position(board) do
      nil ->
        []

      empty_pos ->
        possible_moves(empty_pos)
        |> Enum.map(fn move ->
          new_board = apply_move(board, empty_pos, move)
          %{board: new_board, visited: MapSet.put(visited, new_board)}
        end)
        |> Enum.filter(fn state -> not MapSet.member?(visited, state.board) end)
    end
  end

  # Finds the position of the empty space (0) in the board.
  defp find_empty_position(board) do
    Enum.find_value(Enum.with_index(board), fn {row, row_index} ->
      Enum.find_value(Enum.with_index(row), fn {cell, col_index} ->
        if cell == 0, do: {row_index, col_index}
      end)
    end)
  end

  # Generates a list of possible moves from the current empty space position.
  defp possible_moves({row, col}) do
    [{row - 1, col}, {row + 1, col}, {row, col - 1}, {row, col + 1}]
    |> Enum.filter(fn {r, c} -> r in 0..2 and c in 0..2 end)
  end

  # Applies a move to the board and returns the new board configuration.
  defp apply_move(board, {row, col}, {new_row, new_col}) do
    value = Enum.at(Enum.at(board, new_row), new_col)

    board
    |> List.update_at(row, fn r -> List.update_at(r, col, fn _ -> value end) end)
    |> List.update_at(new_row, fn r -> List.update_at(r, new_col, fn _ -> 0 end) end)
  end
end
