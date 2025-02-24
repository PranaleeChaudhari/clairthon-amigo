FROM node:18 as build 
EXPOSE 80
WORKDIR /react-app
COPY package*.json ./
RUN yarn install --frozen-lockfile --network-timeout 1000000
COPY . .
RUN yarn run build
FROM nginx:1.19
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /react-app/build /usr/share/nginx/html