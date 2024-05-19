defmodule Backfish.LargeGraph do
  def generate_graph(n) do
    for i <- 1..n, into: %{} do
      {i, neighbors(i, n)}
    end
  end

  defp neighbors(i, n) do
    [
      rem(i + 1, n) + 1,
      rem(i + 2, n) + 1,
      rem(i - 1, n) + 1,
      rem(i - 2, n) + 1
    ]
    |> Enum.uniq()
    |> Enum.reject(&(&1 == i))
  end
end
