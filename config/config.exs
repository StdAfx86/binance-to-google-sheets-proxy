import Config

config :http_proxy,
  https: false,
  proxies: [    
    %{port: 4001, to: "https://api1.binance.com/"},
    %{port: 4002, to: "https://api2.binance.com/"},
    %{port: 4003, to: "https://api3.binance.com/"},
    %{port: 4004, to: "https://fapi.binance.com/"},
    %{port: 4005, to: "https://dapi.binance.com/"}
  ],
  timeout: 30_000
