defmodule Swifty.Mixfile do
  use Mix.Project

  def project do
    [ app: :swifty,
      version: "0.0.1",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  defp deps do
    [{:elli, github: "knutin/elli"}]
  end
end
