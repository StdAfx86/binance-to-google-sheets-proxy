FROM elixir:1.15-alpine

# Устанавливаем нужные пакеты для сборки Erlang/Elixir зависимостей
RUN apk add --no-cache \
    git \
    bash \
    curl \
    openssl-dev \
    erlang-dev \
    erlang-ssl \
    build-base \
    make \
    gcc \
    musl-dev

WORKDIR /app

COPY . .

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix deps.compile

CMD ["mix", "run", "--no-halt"]
