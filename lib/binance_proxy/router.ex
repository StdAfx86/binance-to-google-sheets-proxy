defmodule BinanceProxy.Router do
  use Plug.Router

  require Logger

  plug :match
  plug :dispatch

  @binance_base "https://api.binance.com"

  match _ do
    # Прокси запрос к Binance API
    url = @binance_base <> conn.request_path <> "?" <> (conn.query_string || "")

    headers =
      conn.req_headers
      |> Enum.filter(fn {k, _v} -> k in ["x-mbx-apikey", "content-type", "user-agent"] end)

    method = conn.method |> String.downcase() |> String.to_atom()

    body = read_body(conn)

    case :hackney.request(method, url, headers, body, []) do
      {:ok, status, resp_headers, client} ->
        {:ok, resp_body} = :hackney.body(client)

        resp_headers
        |> Enum.each(fn {k, v} -> Plug.Conn.put_resp_header(conn, k, v) end)

        send_resp(conn, status, resp_body)

      {:error, reason} ->
        Logger.error("Proxy error: #{inspect(reason)}")
        send_resp(conn, 502, "Bad Gateway")
    end
  end

  defp read_body(conn) do
    case Plug.Conn.read_body(conn) do
      {:ok, body, _conn} -> body
      {:more, body, _conn} -> body
      {:error, _} -> ""
    end
  end
end
