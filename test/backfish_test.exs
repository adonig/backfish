defmodule BackfishTest do
  use ExUnit.Case
  doctest Backfish

  test "greets the world" do
    assert Backfish.hello() == :world
  end
end
