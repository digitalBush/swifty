defmodule Swifty.Resource do

	defmacro __using__(opts) do
		path = Keyword.get(opts, :path)
		Module.put_attribute(__CALLER__.module, :resource_path, path)
	    quote do
	    	import Swifty.Resource
	    end
	end

	defmacro get(path, do: block) do
		handle(:GET,path,__CALLER__.module,block)
	end

	defmacro post(path, do: block) do
		handle(:POST,path,__CALLER__.module,block)
	end

	defmacro put(path, do: block) do
		handle(:PUT,path,__CALLER__.module,block)
	end

	defmacro delete(path, do: block) do
		handle(:DELETE,path,__CALLER__.module,block)
	end

	defmacro handle(verb, path, do: block) when is_atom(verb) do
		handle(verb,path,__CALLER__.module,block)
	end

	defp handle(verb,path,_module,block) do
		resource_path = Module.get_attribute _module, :resource_path
		route = Swifty.Utils.split_path resource_path <> "/" <> path
		quote do
			def handle(unquote(verb), unquote(route), request) do
				unquote(block)
			end
		end
	end
end