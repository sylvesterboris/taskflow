# Backend Dockerfile using node:18-alpine
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Expose port 4000 (backend default)
EXPOSE 4000

# Start the server
CMD ["npm", "start"]