## Exercise 3_3

### Step 1
Clone the exercise 2_8

### Step 2
Edit the `Dockerfile` of the frontend by adding non-root user and give the non-root user the ownership of the workdir in the image.

Dockerfile for the frontend
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

### Step 3
Edit the `Dockerfile` of the backend by adding non-root user and give the non-root user the ownership of the workdir in the image.

Dockerfile for the backend

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

### Step 4
Run command `docker-compose up`, the application works as before as non-root user.
