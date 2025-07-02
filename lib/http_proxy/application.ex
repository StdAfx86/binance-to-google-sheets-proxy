defmodule HttpProxy.Application do
  use Application

  def start(_type, _args) do
    children = [
      {
        Plug.Cowboy,
        scheme: :http,
        plug: HttpProxy.Handle,
        options: [port: 10000]
      }
    ]

    opts = [strategy: :one_for_one, name: HttpProxy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
