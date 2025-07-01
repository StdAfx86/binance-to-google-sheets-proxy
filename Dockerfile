FROM elixir:1.15-alpine

RUN apk add --no-cache git bash curl

WORKDIR /app

COPY . .

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get || true

CMD ["elixir", "main.exs"]
