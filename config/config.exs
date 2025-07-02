import Config

config :http_proxy,
  http: [port: String.to_integer(System.get_env("PORT") || "10000")],
  proxies: [
    %{port: 10000, to: "https://api.binance.com"}
  ],
  timeout: 30_000