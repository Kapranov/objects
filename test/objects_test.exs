defmodule ObjectsTest do
  use ExUnit.Case
  doctest Objects

  test "greets the world" do
    assert Objects.hello() == :world
  end
end
