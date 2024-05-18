defmodule Backfish.ProblemDefinition do
  @moduledoc """
  A behaviour module for defining problems that can be solved using the Backfish
  backtracking library.

  This module provides three callback functions that must be implemented by any
  module that uses it:
  - `initial_state/1`
  - `is_goal?/1`
  - `next_steps/1`

  The `__using__` macro also defines default implementations for these callbacks
  that raise errors, ensuring that any module using this behaviour implements its
  own versions of these functions.
  """

  @doc """
  Returns the initial state of the problem.

  ## Parameters

    - `args`: A keyword list of arguments that can be used to customize the
      initial state.

  ## Returns

    - The initial state of the problem.
  """
  @callback initial_state(args :: keyword()) :: any()

  @doc """
  Checks if the given state is a goal state.

  ## Parameters

    - `state`: The current state of the problem.

  ## Returns

    - `true` if the state is a goal state, `false` otherwise.
  """
  @callback is_goal?(state :: any()) :: boolean()

  @doc """
  Generates the next possible states from the given state.

  ## Parameters

    - `state`: The current state of the problem.

  ## Returns

    - A list of the next possible states.
  """
  @callback next_steps(state :: any()) :: [any()]

  @doc false
  defmacro __using__(_opts) do
    quote do
      @behaviour Backfish.ProblemDefinition

      @doc """
      Returns the initial state of the problem.

      This function must be implemented by any module using the
      `Backfish.ProblemDefinition` behaviour.
      """
      def initial_state(_args) do
        raise "initial_state/1 not implemented"
      end

      @doc """
      Checks if the given state is a goal state.

      This function must be implemented by any module using the
      `Backfish.ProblemDefinition` behaviour.
      """
      def is_goal?(_state) do
        raise "is_goal?/1 not implemented"
      end

      @doc """
      Generates the next possible states from the given state.

      This function must be implemented by any module using the
      `Backfish.ProblemDefinition` behaviour.
      """
      def next_steps(_state) do
        raise "next_steps/1 not implemented"
      end

      defoverridable Backfish.ProblemDefinition
    end
  end
end
