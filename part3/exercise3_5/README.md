## Exercise 3_5

### Dockerfile for the frontend

Before
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
After
```
FROM node:16-alpine3.11

WORKDIR /usr/src/app

COPY . .

RUN npm install && \
    npm run build && \
    npm install -g serve && \
    adduser -S appuser && \
    chown appuser -R /usr/src/app

USER appuser

EXPOSE 3000

CMD ["serve", "-s", "-l", "3000", "build"]
```

The image size from `406 mb` to `403 mb`

### Dockerfile for the backend

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
The `Dockerfile` for the backend is kept as the exercise 3_4 because it has already optimized. The images size is `24.2 mb`
