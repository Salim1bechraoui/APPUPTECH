FROM node:12.20-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm cache clean --force
RUN npm ci
RUN npm i
COPY . .
RUN npm run build --prod

FROM nginx:latest

COPY --from=build /dist/APPUPtech /usr/share/nginx/html

