# build stage
FROM golang:1.23-alpine3.21 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.18.1/migrate.linux-amd64.tar.gz | tar -xz
# Not: "migrate.darwin-amd64.tar.gz" yerine "migrate.linux-amd64.tar.gz" kullanılıyor

# run stage
FROM alpine:3.21
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate.linux-amd64 /usr/bin/migrate
COPY app.env .
COPY start.sh .
COPY wait-for.sh .
COPY db/migration ./migration

# Konteynerın 8080 numaralı portunu dışa açar
EXPOSE 8080

# ENTRYPOINT ve CMD mantığını düzeltmek için sırayı değiştirdim
ENTRYPOINT [ "/app/start.sh" ]
CMD [ "/app/main" ]
