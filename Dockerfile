FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN apk add --no-cache build-base gcc autoconf automake libtool zlib-dev libpng-dev nasm 
RUN npm install -g npm@latest
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html 

