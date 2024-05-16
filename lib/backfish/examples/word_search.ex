defmodule Backfish.Examples.WordSearch do
  use Backfish.ProblemDefinition

  def initial_state(args) do
    board = Keyword.get(args, :board, [])
    words = Keyword.get(args, :words, [])
    %{board: board, words: words, found_words: [], paths: []}
  end

  def is_goal?(%{words: words, found_words: found_words}) do
    Enum.sort(words) == Enum.sort(found_words)
  end

  def next_steps(%{
        board: board,
        words: words,
        found_words: found_words,
        paths: paths
      }) do
    Enum.flat_map(words -- found_words, fn word ->
      find_word(board, word)
      |> Enum.map(fn path ->
        %{
          board: board,
          words: words,
          found_words: [word | found_words],
          paths: [path | paths]
        }
      end)
    end)
  end

  defp find_word(board, word) do
    for row <- 0..(length(board) - 1),
        col <- 0..(length(Enum.at(board, row)) - 1),
        path <- search_from(board, word, {row, col}, [], {0, 0}),
        do: path
  end

  defp search_from(_board, "", _pos, path, _direction), do: [Enum.reverse(path)]

  defp search_from(board, word, {row, col}, path, {dr, dc}) do
    cond do
      row < 0 or row >= length(board) ->
        []

      col < 0 or col >= length(Enum.at(board, row)) ->
        []

      Enum.at(Enum.at(board, row), col) != String.first(word) ->
        []

      true ->
        rest = String.slice(word, 1..-1//1)

        directions =
          if path == [],
            do: [{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}],
            else: [{dr, dc}]

        Enum.flat_map(directions, fn {dr, dc} ->
          search_from(board, rest, {row + dr, col + dc}, [{row, col} | path], {dr, dc})
        end)
    end
  end
end
