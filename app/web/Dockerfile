FROM node:18 AS base
CMD ["bash"]

FROM base AS test_build
WORKDIR /app
COPY . .
ARG REACT_APP_API_URL
RUN npm ci && npm run test && npm run build

FROM nginx:latest AS prod
COPY --from=test_build /app/build /var/www/
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
