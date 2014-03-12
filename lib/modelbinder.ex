defmodule Swifty.ModelBinder do

    def create(module, source) when is_atom(module) do
        {struct, filtered} = filter(source, module)
        Dict.merge(struct, filtered, &merge/3)
    end

    def update(model, source) when is_map(model) do
        %{__struct__: module}=model
        {_struct, filtered} = filter(source,module)
        Dict.merge(model, filtered, &merge/3)
    end

    defp filter(source, module) do
        struct = apply(module, :__struct__, [])
        keys = Dict.keys(struct)
        filtered=Dict.take(source, keys)
        {struct, filtered}
    end

    defp merge(_key, dest, source) when is_map(dest) do
        update(dest, source)
    end

    defp merge(_key, _dest, source) do
        source
    end
end
