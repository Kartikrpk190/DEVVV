# syntax=docker/dockerfile:1
FROM docker
COPY --from=docker/buildx-bin /buildx /usr/libexec/docker/cli-plugins/docker-buildx
RUN docker buildx version

FROM node:16
WORKDIR /app
COPY . .
RUN apt update
RUN npm install --package-lock-only --legacy-peer-deps
RUN npm run build
RUN apt install -y nginx
RUN rm -rf /var/www/html/*
COPY /build /var/www/html
CMD ["nginx", "-g", "daemon off;"]

