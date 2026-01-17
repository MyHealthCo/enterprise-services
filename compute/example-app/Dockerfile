FROM cgr.dev/chainguard/go:latest-dev AS build

WORKDIR /app

COPY go.mod ./
COPY main.go ./

RUN CGO_ENABLED=0 go build -o /app/example-app

FROM cgr.dev/chainguard/static:latest AS runtime

WORKDIR /app

COPY --from=build /app/example-app /app/example-app

EXPOSE 8080

ENTRYPOINT ["/app/example-app"]
