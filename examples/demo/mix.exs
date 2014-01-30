defmodule Demo.Mixfile do
  use Mix.Project

  def project do
    [ app: :demo,
      version: "0.0.1",
      elixir: "~> 0.12.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ registered: [:demo],
      mod: {Demo, [port: 3000]}]
  end

  defp deps do
    [{ :swifty, path: "../.."}]
  end
end
