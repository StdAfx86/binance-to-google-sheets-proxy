# 1. Используем официальный Elixir-образ
FROM elixir:1.15

# 2. Устанавливаем зависимости (build tools)
RUN apt-get update && apt-get install -y \
  build-essential \
  openssl \
  && rm -rf /var/lib/apt/lists/*

# 3. Устанавливаем рабочую директорию
WORKDIR /app

# 4. Копируем файлы проекта
COPY . .

# 5. Устанавливаем зависимости и компилируем
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix compile

# 6. Генерируем самоподписанный сертификат
RUN mkdir -p priv/ssl && \
    openssl req -x509 -newkey rsa:4096 -keyout priv/ssl/privkey.pem \
    -out priv/ssl/fullchain.pem -days 365 -nodes \
    -subj "/CN=localhost"

# 7. Указываем порты для HTTP и HTTPS
EXPOSE 80 443 5000 5001 5002 5003 5004 5005

# 8. Запуск приложения
CMD ["mix", "run", "--no-halt"]
