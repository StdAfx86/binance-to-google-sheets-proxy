import Config

config :http_proxy,
  http: [port: 80], # необязательно, если нужен только HTTPS
  https: [
    port: 443,
    cipher_suite: :strong,
    keyfile: "priv/ssl/privkey.pem",
    certfile: "priv/ssl/fullchain.pem"
  ],
  proxies: [
    %{port: 5000, to: "https://api.binance.com/"},
    %{port: 5001, to: "https://api1.binance.com/"},
    %{port: 5002, to: "https://api2.binance.com/"},
    %{port: 5003, to: "https://api3.binance.com/"},
    %{port: 5004, to: "https://fapi.binance.com/"},
    %{port: 5005, to: "https://dapi.binance.com/"}
  ],
  timeout: 30_000