defmodule Backfish.ProblemDefinition do
  @callback initial_state(args :: keyword()) :: any()
  @callback is_goal?(state :: any()) :: boolean()
  @callback next_steps(state :: any()) :: [any()]

  defmacro __using__(_opts) do
    quote do
      @behaviour Backfish.ProblemDefinition

      def initial_state(_args) do
        raise "initial_state/1 not implemented"
      end

      def is_goal?(_state) do
        raise "is_goal?/1 not implemented"
      end

      def next_steps(_state) do
        raise "next_steps/1 not implemented"
      end

      defoverridable Backfish.ProblemDefinition
    end
  end
end
