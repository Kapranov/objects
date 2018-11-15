defmodule Objects do
  @moduledoc false

  alias Objects.Builder

  defmacro class(class_expr, block, opts \\ []) do
    {class, superclasses} =
      case class_expr do
        {:<, _, [class, superclasses]} when is_list(superclasses) ->
          {class, superclasses}

        {:<, _, [class, superclass]} ->
          {class, [superclass]}

        class ->
          {class, []}
      end

    Builder.create_class(class, superclasses, block, opts)
  end

  defmacro abstract(class_expr, block) do
    {:class, _, [class]} = class_expr

    quote do
      Objects.class(unquote(class), unquote(block), abstract: true)
    end
  end
end
