import Config

config :http_proxy,
  proxies: [%{port: 10000, to: "https://api.binance.com"}],
  timeout: 30_000