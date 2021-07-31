## Description
This is the instruction to deploy an application to Heroku using image

## Setup instruction 
```
docker pull devopsdockeruh/heroku-example

docker tag devopsdockeruh/heroku-example registry.heroku.com/hien-heroku/web

heroku login

heroku container:login

docker push registry.heroku.com/hien-heroku/web

heroku container:release web -a hien-heroku
```

The service can be accessed via [https://hien-heroku.herokuapp.com/](https://hien-heroku.herokuapp.com/)