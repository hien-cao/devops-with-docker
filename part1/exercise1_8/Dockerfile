FROM ubuntu:18.04

WORKDIR /usr/src/app

COPY website.sh .

RUN apt-get update && \
    apt-get -y install curl && \
    apt-get clean && \
    chmod +x website.sh

CMD ["./website.sh"]
