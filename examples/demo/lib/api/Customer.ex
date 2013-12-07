defmodule Api.Customer do
	use Swifty.Resource, path: "/customer"

	get ":id" do
		IO.puts("getting customer info")
		{:ok,[],"From Module"}
	end

	post "/" do
		IO.puts("adding new customer")
		{:ok,[],"From Module"}
	end


end