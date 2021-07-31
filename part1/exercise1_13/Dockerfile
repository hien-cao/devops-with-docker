# Get golang 1.16
FROM golang:1.16

WORKDIR /usr/src/app

EXPOSE 8080

COPY . .

ENV REQUEST_ORIGIN=http://localhost:5000

# Build the project
RUN go build

CMD ["./server"]
