## Exercise 3_6

### Dockerfile for the frontend

```
FROM node:16-alpine3.11 as build-stage

WORKDIR /usr/src/app

COPY . .

RUN npm install && \
    npm run build

FROM nginx:1.16.0-alpine

COPY nginx.conf /etc/nginx/conf.d

COPY --from=build-stage /usr/src/app/build /usr/share/nginx/html
```

The image size of the frontend is `21.6 mb`

### Dockerfile for the backend

```
FROM golang:alpine AS build-env
WORKDIR /usr/src/app
ADD . .
RUN env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o goapp

FROM scratch
WORKDIR /usr/src/app
COPY --from=build-env /usr/src/app/goapp /usr/src/app
EXPOSE 8080
CMD ["./goapp"]
```
The images size is `18 mb`
