defmodule BinanceProxy.MixProject do
  use Mix.Project

  def project do
    [
      app: :binance_proxy,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {BinanceProxy.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.6"},
      {:hackney, "~> 1.18"},
      {:jason, "~> 1.4"}
    ]
  end
end
