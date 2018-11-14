defmodule Objects.Registry do
  @moduledoc false
  @name __MODULE__

  @doc false
  def start_link do
    Agent.start_link(fn -> Map.new end, name: @name)
  end

  @doc false
  def get(pid) do
    Agent.get(@name, &Map.get(&1, pid, nil))
  end

  @doc false
  def register(pid, class) do
    Agent.update(@name, &Map.put(&1, pid, class))
  end
end
