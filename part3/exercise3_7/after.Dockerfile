FROM node:16-alpine3.11 as build-stage

WORKDIR /usr/src/app

COPY . .

RUN npm install && \
    npm run build

FROM nginx:1.17.6

WORKDIR /usr/src/app

COPY /nginx/default.conf /etc/nginx/conf.d/default.conf
COPY /nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build-stage /usr/src/app/build /usr/share/nginx/html

## add permissions for nginx user
RUN chown -R nginx:nginx /usr/src/app && chmod -R 755 /usr/src/app && \
        chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid
COPY /nginx/error.log /var/nginx/log/error.log 

RUN chown -R nginx:nginx /var/nginx/log/error.log

USER nginx

CMD ["nginx", "-g", "daemon off;"]
