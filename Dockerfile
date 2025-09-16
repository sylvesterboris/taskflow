# Frontend Dockerfile (multi-stage) - builds Vite app and serves with Nginx

# ====== Build Stage ======
FROM node:20-alpine AS build
WORKDIR /app

# Only copy package files first for better layer caching
COPY package*.json ./
RUN npm ci --omit=dev=false

# Copy source and build
COPY . .

# Build-time API base URL (default to http://localhost:4000)
ARG VITE_API_BASE_URL=http://localhost:4000
ENV VITE_API_BASE_URL=${VITE_API_BASE_URL}

RUN npm run build

# ====== Runtime Stage ======
FROM nginx:1.27-alpine AS runtime

# Copy custom nginx config for SPA
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built assets
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]





