## Exercise 2_11

I am using Create React App to create a basic frontend application which display text in the web browser. This application intends to use as an application to be containered using docker.

Firstly, a `Dockerfile` is created which only copies all `package` file with the purpose of packing the environment runing the application. 

Secondly, a `docker-compose` file is created to start a container from the environment image, then the source code is mounted to a volume which also connected to the container. Once a code is changed, it is automatically complied and updated in the web-browser. 

## Setup

Clone the application and run the following command to start the application.

```
docker-compose up
```

