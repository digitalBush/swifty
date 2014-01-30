defmodule Swifty.Mixfile do
  use Mix.Project

  def project do
    [ app: :swifty,
      version: "0.0.1",
      elixir: "~> 0.12.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  defp deps do
    [{:wubba, github: "digitalBush/wubba"}]
  end
end
