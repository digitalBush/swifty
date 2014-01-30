defmodule Swifty.Bootstrap do
	defmacro __using__(opts // []) do 
		path = Keyword.get(opts, :path, "lib/handlers")
		
		behavior = quote do
			@behaviour :elli_handler

			def handle(request, _args) do
				Wubba.Request[method: method, path: path] = request
			    handle(method, path, request)
			end

			def handle_event(_event, _data, _args) do
			    :ok
			end
		end

		[behavior | resources(path)]
	end

	defp resources(path) do 
		IO.puts("Loading resources from #{path}")

		routes=File.ls!(path) 
		|> Enum.map(&(Path.join path, &1))
		|> Enum.map(&load_modules_from_file/1)
		|> List.flatten

		#TODO: do we need to dig further and get full paths inside of resources?
		#TODO: order routes.

		handlers = Enum.map routes,fn({module,path}) ->
			route = Swifty.Utils.split_path path
			quote do
				def handle(method, [unquote_splicing(route)|_]=route, request) do
					unquote(module).handle(method,route,request)
				end
			end
		end

		handlers ++ [fallback]
	end

	defp load_modules_from_file(file) do
		contents = File.read!(file)

		forms = Code.string_to_quoted!(String.to_char_list!(contents), [line: 1, file: file])
		get_modules(forms)
	end

	defp get_modules({:__block__, [], modules}) do
		lc module inlist modules, do: get_modules(module)
	end

	defp get_modules({:defmodule,_line, [module_name,block|_]}) do
		{:__aliases__, _line, namespace} = module_name 
		[{:do,{:__block__,_,[resource|_]}}] = block
		{:use, _line, [{:__aliases__, _line, [:Swifty,:Resource]}, [path: prefix]]} = resource
		[{Module.concat(namespace), prefix}]
	end

	defp fallback do
	    quote do
	      	def handle(_method,_path,_req) do
	      		{404, [], <<"Not Found">>}
	      	end
	    end
	end
end