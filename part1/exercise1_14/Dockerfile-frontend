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

ENV REACT_APP_BACKEND_URL=http://localhost:8080

# Build the static files
RUN npm run build

# Install serve
RUN npm install -g serve

CMD ["serve", "-s", "-l", "5000", "build"]
