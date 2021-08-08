## Exercise 3_7

For this exercise, I use the react app in exercise 1_15. The app is created using create-react-app.

Original Dockerfile with size `840 mb`
```
# Install curl
RUN apt-get update && apt-get install -y curl

# Install nodejs 14.x
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash
RUN apt install -y nodejs

# Install all packages
RUN npm install -g yarn

RUN yarn

RUN yarn build

# Install serve
RUN npm install -g serve

# Add app user
RUN useradd -m appuser
RUN chown appuser -R /usr/src/app

USER appuser
CMD ["serve", "-s", "-l", "5000", "build"]
```

Minimized Dockerfile with added security having size `127 mb`

```
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
```