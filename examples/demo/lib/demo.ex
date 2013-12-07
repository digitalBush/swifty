defmodule Demo do
	use Swifty.Bootstrap, path: "lib/api"
	use Application.Behaviour

	def start(_type, state) do
	  { :ok, _pid } = :elli.start_link [callback: __MODULE__, port: state[:port]]
	end
end
