FROM elixir:1.15-alpine

RUN apk add --no-cache git bash curl openssl-dev

WORKDIR /app

COPY . .

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix deps.compile ssl_verify_fun --force

CMD ["mix", "run", "--no-halt"]
