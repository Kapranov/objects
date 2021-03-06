defmodule Objects.Builder do
  @moduledoc false

  alias Objects.Builder
  alias Objects.Registry

  def create_class(class, superclasses, _block, opts) do
    quote do
      defmodule unquote(class) do
        Builder.ensure_can_be_subclassed(unquote(superclasses))

        @final Keyword.get(unquote(opts), :final, false)

        def __final__? do
          @final
        end

        def new(data \\ [], descendant? \\ false) do
          Builder.ensure_can_be_instantiated(unquote(class), descendant?, unquote(opts))

          object = :"#{unquote(class)}#{:erlang.unique_integer()}"

          defmodule object do
            use GenServer

            def start_link(data) do
              GenServer.start_link(__MODULE__, data, name: __MODULE__)
            end

            def class do
              unquote(class)
            end

            def methods do
            end
          end
        end
      end
    end
  end

  def create_method(call, expr) do
    using_this? = String.match?(Macro.to_string(expr), ~r"\bthis\.")

    {method, args} = Macro.decompose_call(call)

    handle_call_quoted =
      quote do
        try do
          [do: value] = unquote(expr)
          {:reply, {:ok, value}, data}
        rescue
          e in [RuntimeError] ->
            {:reply, {:error, e}, data}
        end
      end

    quote do
      def unquote(call) do
        case GenServer.call(__MODULE__, {:call, unquote(method), unquote(args)}) do
          {:ok, value} -> value
          {:error, e} -> raise e
        end
      end

      if unquote(using_this?) do
        def handle_call({:call, unquote(method), unquote(args)}, _from, data) do
          var!(this) = data
          unquote(handle_call_quoted)
        end
      else
        def handle_call({:call, unquote(method), unquote(args)}, _from, data) do
          unquote(handle_call_quoted)
        end
      end
    end
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
