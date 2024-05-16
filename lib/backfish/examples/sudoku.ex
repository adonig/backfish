defmodule Backfish.Examples.Sudoku do
  use Backfish.ProblemDefinition

  def initial_state(args) do
    board = Keyword.get(args, :board, [])
    size = length(board)
    %{board: board, size: size}
  end

  def is_goal?(%{board: board, size: size}) do
    Enum.all?(for row <- board, cell <- row, do: cell in 1..size)
  end

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

  defp find_empty_cell(board) do
    Enum.find_value(Enum.with_index(board), fn {row, row_index} ->
      Enum.find_value(Enum.with_index(row), fn {cell, col_index} ->
        if cell == 0, do: {row_index, col_index}
      end)
    end)
  end

  defp valid?(board, {row, col}, num) do
    valid_row?(board, row, num) and valid_col?(board, col, num) and
      valid_box?(board, {row, col}, num)
  end

  defp valid_row?(board, row, num) do
    Enum.all?(board |> Enum.at(row), fn cell -> cell != num end)
  end

  defp valid_col?(board, col, num) do
    Enum.all?(board, fn row -> Enum.at(row, col) != num end)
  end

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

  defp update_board(board, {row, col}, num) do
    List.update_at(board, row, fn row_list ->
      List.update_at(row_list, col, fn _ -> num end)
    end)
  end
end
