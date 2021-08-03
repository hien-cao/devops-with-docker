FROM ubuntu:18.04

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y curl && apt-get install -y git

RUN curl -sSL https://get.docker.com/ | sh

COPY script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["./script.sh"]
