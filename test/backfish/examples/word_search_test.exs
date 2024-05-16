defmodule Backfish.Examples.WordSearchTest do
  use ExUnit.Case, async: true

  alias Backfish.Examples.WordSearch

  test "finds all words in the word search puzzle" do
    board = [
      ["I", "G", "O", "N", "G", "N", "T", "E", "R", "E", "T", "T", "O", "R"],
      ["Y", "W", "L", "R", "O", "R", "G", "R", "A", "C", "C", "O", "O", "N"],
      ["L", "K", "S", "U", "O", "E", "B", "U", "F", "F", "A", "L", "O", "Y"],
      ["A", "S", "F", "A", "S", "G", "G", "A", "L", "A", "N", "W", "E", "K"],
      ["L", "A", "A", "G", "E", "I", "E", "I", "L", "F", "M", "O", "A", "U"],
      ["L", "L", "K", "O", "R", "T", "I", "A", "R", "A", "W", "R", "A", "W"],
      ["D", "E", "R", "R", "E", "E", "L", "A", "C", "A", "I", "M", "R", "L"],
      ["R", "S", "A", "F", "F", "O", "M", "N", "N", "L", "F", "E", "O", "S"],
      ["D", "A", "H", "E", "B", "T", "L", "Y", "I", "K", "A", "F", "O", "N"],
      ["O", "E", "S", "S", "A", "L", "A", "O", "K", "U", "A", "T", "E", "A"],
      ["G", "W", "T", "T", "E", "A", "G", "L", "E", "N", "G", "H", "R", "I"],
      ["F", "E", "R", "L", "R", "F", "L", "K", "F", "R", "B", "N", "F", "L"],
      ["R", "A", "R", "E", "D", "N", "A", "M", "A", "L", "A", "S", "E", "O"],
      ["Y", "E", "K", "N", "O", "M", "O", "E", "A", "Y", "E", "Y", "E", "P"]
    ]

    words = [
      "GIRAFFE",
      "MONKEY",
      "OWL",
      "PENGUIN",
      "BUFFALO",
      "EAGLE",
      "LOBSTER",
      "SNAIL",
      "TIGER",
      "FROG",
      "WEASEL",
      "SALAMANDER",
      "RACCOON",
      "KOALA",
      "GOOSE",
      "YAK",
      "SHARK",
      "WORM",
      "OTTER"
    ]

    {:ok, solution} =
      Backfish.find_first_solution(WordSearch,
        args: [board: board, words: words]
      )

    assert WordSearch.is_goal?(solution)
  end
end
