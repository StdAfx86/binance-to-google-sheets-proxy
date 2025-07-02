defmodule BinanceProxy.Application do
  use Application

  def start(_type, _args) do
    port = String.to_integer(System.get_env("PORT") || "10000")

    children = [
      {Plug.Cowboy, scheme: :http, plug: BinanceProxy.Router, options: [port: port]}
    ]

    opts = [strategy: :one_for_one, name: BinanceProxy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
