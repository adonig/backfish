# Backfish

**Backfish** is a flexible and powerful backtracking library for Elixir, designed to solve combinatorial and constraint satisfaction problems. Whether you're working on puzzles like Sudoku, N-Queens, Word Search, or graph problems like the Hamiltonian Path, Backfish provides the tools you need to implement efficient solutions.

## Features

- Easy-to-use API for defining problem states, goals, and next steps.
- Supports finding the first valid solution or all possible solutions.
- Extensible to a wide variety of problem domains.

## Installation

Add `backfish` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:backfish, "~> 0.1.0"}
  ]
end
```

## Usage

### Defining a Problem

To define a problem, you need to create a module that uses `Backfish.ProblemDefinition` and implements the required callbacks: `initial_state/1`, `is_goal?/1`, and `next_steps/1`.

#### Example: N-Queens

``` elixir
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
```

### Finding Solutions

Use `Backfish.find_first_solution/2` to find the first valid solution or `Backfish.find_all_solutions/2` to find all possible solutions.

#### Example: Solving N-Queens

``` elixir
opts = [args: [size: 8]]

{:ok, solution} = Backfish.find_first_solution(Backfish.Examples.NQueens, opts)
IO.inspect(solution)

solutions = Backfish.find_all_solutions(Backfish.Examples.NQueens, opts)
IO.inspect(length(solutions))
```

### Additional Examples

- [Eight Puzzle](lib/backfish/examples/eight_puzzle.ex)
- [Graph Coloring](lib/backfish/examples/graph_coloring.ex)
- [Hamiltonian Path](lib/backfish/examples/hamiltonian_path.ex)
- [Knapsack](lib/backfish/examples/knapsack.ex)
- [Sudoku](lib/backfish/examples/sudoku.ex)
- [Word Search](lib/backfish/examples/word_search.ex)

## Contributing

Contributions to improve Backfish are welcome. Please fork the repository and submit pull requests.

## Documentation

Documentation can be generated with ExDoc and published on HexDocs. Once published, the docs can be found [here](https://hexdocs.pm/backfish).

## License

Backfish is released under the [MIT License](LICENSE).

## Credits

Special thanks to [ChatGPT 4o](https://chat.openai.com/) for helping me build this library in 3 days.
