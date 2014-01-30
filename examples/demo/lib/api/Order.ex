defmodule Api.Order do
	use Swifty.Resource, path: "/order"

	get ":id" do
		{:ok,[],"Order #{id}"}
	end

	post "" do
		foo()
		IO.puts("adding new order")
		{:ok,[],"From Module"}
	end

	defp foo(),do: IO.puts("calling private method")
end

defmodule Api.Orders do
	use Swifty.Resource, path: "/orders"

	get "" do
		IO.puts("getting all orders")
		{:ok,[],"From Module"}
	end
end