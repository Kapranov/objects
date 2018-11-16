defmodule Objects.Builder do
  @moduledoc false

  alias Objects.Registry

  def create_class(_class, _superclasses, _block, _opts) do
  end

  def create_method(_call, _expr) do
  end

  def create_var(field, opts) do
    private? = Keyword.get(opts, :private, false)

    quote do
      def unquote(field)() do
        case GenServer.call(__MODULE__, {:get, unquote(field)}) do
          {:ok, value} -> value
          {:error, :private} -> raise "Cannot access private var #{unquote(field)}"
        end
      end

      def unquote(:"set_#{field}")(value) do
        GenServer.call(__MODULE__, {:set, unquote(field), value})
      end

      def handle_call({:get, unquote(field)}, {pid, _ref}, data) do
        classes = [class() | @friends]

        if unquote(private?) and Registry.get(pid) not in classes do
          {:reply, {:error, :private}, data}
        else
          {:reply, {:ok, Map.get(data, unquote(field))}, data}
        end
      end

      def handle_call({:set, unquote(field), value}, _from, data) do
        {:reply, value, Map.put(data, unquote(field), value)}
      end
    end
  end
end
