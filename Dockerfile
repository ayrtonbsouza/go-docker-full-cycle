FROM golang:alpine AS builder

WORKDIR /app

COPY . .

RUN go mod init hello && \
  go mod tidy && \
  go get -d -v ./... && \
  go install -v ./... && \
  go build -o hello hello.go

FROM scratch
COPY --from=builder /go/bin/hello /go/bin/hello

ENTRYPOINT ["/go/bin/hello"]