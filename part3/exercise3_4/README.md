## Exercise 3_4

### Dockerfile for the frontend

Before
```
# Dockerfile for frontend
FROM ubuntu:18.04

WORKDIR /usr/src/app

EXPOSE 5000

COPY . .

# Install curl
RUN apt-get update && apt-get install -y curl

# Install nodejs 14.x
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash
RUN apt install -y nodejs

# Install all packages
RUN npm install

# Build the static files
RUN npm run build

# Add app user
RUN useradd -m appuser
RUN chown appuser -R /usr/src/app

# Install serve
RUN npm install -g serve

USER appuser

CMD ["serve", "-s", "-l", "5000", "build"]
```
After
```
FROM ubuntu:18.04

WORKDIR /usr/src/app

COPY . .

RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash && \
    apt install -y nodejs && \
    useradd -m appuser && \
    chown appuser -R /usr/src/app && \
    npm install && \
    apt-get purge -y --auto-remove curl && \
    rm -rf /var/lib/apt/lists/*

USER appuser

EXPOSE 3000

CMD ["npm", "start"]
```

The image size from `682 mb` to `406 mb`

### Dockerfile for the backend

Before 
```
# Dockerfile for backend
FROM golang:1.16

WORKDIR /usr/src/app

EXPOSE 8080

COPY . .

# Add app user
RUN useradd -m appuser
RUN chown appuser -R /usr/src/app

# Build the project
RUN go build

CMD ["./server"]
```

After 
```
FROM golang:alpine AS build-env
WORKDIR /usr/src/app
ADD . .
RUN cd /usr/src/app && go build -o goapp

FROM alpine
WORKDIR /usr/src/app
RUN apk update && \
    apk add ca-certificates && \
    rm -rf /var/cache/apk/* && \
    addgroup -S appgroup && \
    adduser -S appuser -G appgroup && \
    chown appuser -R /usr/src/app

USER appuser
COPY --from=build-env /usr/src/app/goapp /usr/src/app
EXPOSE 8080
CMD ["./goapp"]
```
The image size from `1 gb` to `24.2 mb`
