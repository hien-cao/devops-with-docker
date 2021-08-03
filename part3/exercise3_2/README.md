# Exercise 3.2

## The exercise content:
Watchtower uses volume to docker.sock socket to access Docker daemon of the host from the container. By leveraging this ourselves we can create our own simple build service.

Create a project that downloads a repository from github, builds a Dockerfile located in the root and then publishes it into Docker Hub.

You can use any programming language / technology for the project implementation. A simple bash script is viable

Then create a Dockerfile for it so that it can be run inside a container.

Make sure that it can build at least some of the example projects.

## Usage

Build the app first:
```
docker image build -t docker_builder .
```

Run the container from the build image with some parameters
```
docker container run -it --rm -v /var/run/docker.sock:/var/run/docker.sock docker_builder [repository HTTPS link] [name of the image] [Dockerhub username] [Dockerhub password]
```
This downloads the app from [repository HTTPS link], builds the image of that project with name [Dockerhub username]/[name of the image], pushes thhe image to Dockerhub
