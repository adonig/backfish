defmodule Backfish.Examples.WordSearch do
  @moduledoc """
  An implementation of the word search puzzle using the Backfish backtracking
  library.

  The word search puzzle involves finding a list of words in a grid of letters.
  Words can be placed horizontally, vertically, or diagonally, and can be read
  forwards or backwards.
  """

  use Backfish.ProblemDefinition

  @doc """
  Returns the initial state of the word search puzzle.

  ## Parameters

    - `args`: A keyword list of arguments. Expects `:board`, which is a 2D list
      representing the letter grid, and `:words`, which is a list of words to
      find in the grid.

  ## Returns

    - A map representing the initial state, including the board, the list of
      words, the found words, and the paths taken to find the words.
  """
  @impl true
  def initial_state(args) do
    board = Keyword.get(args, :board, [])
    words = Keyword.get(args, :words, [])
    %{board: board, words: words, found_words: [], paths: []}
  end

  @doc """
  Checks if the given state is a goal state.

  ## Parameters

    - `state`: The current state of the problem, which includes the list of
      words and the found words.

  ## Returns

    - `true` if all words have been found, `false` otherwise.
  """
  @impl true
  def is_goal?(%{words: words, found_words: found_words}) do
    Enum.sort(words) == Enum.sort(found_words)
  end

  @doc """
  Generates the next possible states from the given state.

  ## Parameters

    - `state`: The current state of the problem, which includes the board, the
      list of words, the found words, and the paths taken to find the words.

  ## Returns

    - A list of the next possible states, each including the updated board,
      the list of words, the updated list of found words, and the updated
      paths.
  """
  @impl true
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

  # Finds all occurrences of a word in the board.
  defp find_word(board, word) do
    for row <- 0..(length(board) - 1),
        col <- 0..(length(Enum.at(board, row)) - 1),
        path <- search_from(board, word, {row, col}, [], {0, 0}),
        do: path
  end

  # Searches for a word starting from a given position.
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
