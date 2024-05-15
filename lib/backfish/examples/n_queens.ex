defmodule Backfish.Examples.NQueens do
  use Backfish.ProblemDefinition

  @default_size 8

  def initial_state(args) do
    size = Keyword.get(args, :size, @default_size)
    %{board: [], size: size}
  end

  def is_goal?(%{board: board, size: size}) do
    length(board) == size
  end

  def next_steps(%{board: board, size: size}) do
    row = length(board) + 1

    1..size
    |> Enum.filter(fn col -> valid_position?(board, {row, col}) end)
    |> Enum.map(fn col -> %{board: [{row, col} | board], size: size} end)
  end

  defp valid_position?(board, {row, col}) do
    Enum.all?(board, fn {r, c} ->
      c != col && abs(c - col) != abs(r - row)
    end)
  end
end
