FROM golang:1.23-alpine AS build
WORKDIR /src
COPY go.mod main.go ./
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /pulse-go .

FROM scratch
COPY --from=build /pulse-go /pulse-go
USER 10001
EXPOSE 8080
ENTRYPOINT ["/pulse-go"]
