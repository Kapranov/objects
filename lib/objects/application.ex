defmodule Objects.Application do
  @moduledoc false

  alias Objects.Registry

  use Application

  def start(_type, _args) do
    Registry.start_link()
  end
end
