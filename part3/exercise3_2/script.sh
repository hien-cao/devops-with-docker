#!/bin/bash

# Argument definition:
# $1: git repository link in HTTPS format
# $2: the name of the image
# $3: dockerhub username
# $4: dockerhub password

echo "The app repository link is: $1"
git clone $1 ./repo

echo "Build the image of the app with name: $3/$2"
docker image build -t $3/$2 ./repo

echo "Login to Docker Hub with username: $3"
docker login --username $3 --password $4

echo "Push the image to Docker Hub"
docker push $3/$2
