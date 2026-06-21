FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
# Use --production (or --omit=dev) when the container only runs the application and does not need build-time dependencies.
COPY . .
RUN npm run build

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
