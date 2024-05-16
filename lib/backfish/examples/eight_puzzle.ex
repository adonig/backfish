defmodule Backfish.Examples.EightPuzzle do
  use Backfish.ProblemDefinition

  @goal_state [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 0]
  ]

  def initial_state(args) do
    board = Keyword.get(args, :board, [])
    %{board: board, visited: MapSet.new([board])}
  end

  def is_goal?(%{board: board}) do
    board == @goal_state
  end

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

  defp find_empty_position(board) do
    Enum.find_value(Enum.with_index(board), fn {row, row_index} ->
      Enum.find_value(Enum.with_index(row), fn {cell, col_index} ->
        if cell == 0, do: {row_index, col_index}
      end)
    end)
  end

  defp possible_moves({row, col}) do
    [{row - 1, col}, {row + 1, col}, {row, col - 1}, {row, col + 1}]
    |> Enum.filter(fn {r, c} -> r in 0..2 and c in 0..2 end)
  end

  defp apply_move(board, {row, col}, {new_row, new_col}) do
    value = Enum.at(Enum.at(board, new_row), new_col)

    board
    |> List.update_at(row, fn r -> List.update_at(r, col, fn _ -> value end) end)
    |> List.update_at(new_row, fn r -> List.update_at(r, new_col, fn _ -> 0 end) end)
  end
end
