# Use Node.js LTS version
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first for better layer caching
COPY package*.json ./

# Install dependencies (use npm install if no package-lock.json exists)
RUN npm install --only=production

# Copy application files
COPY . .

# Create a non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S ctfuser -u 1001 -s /bin/sh

# Change ownership of the app directory
RUN chown -R ctfuser:nodejs /app

# Switch to non-root user
USER ctfuser

# Expose the port
EXPOSE 4012

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:4012', (res) => { process.exit(res.statusCode === 200 ? 0 : 1) }).on('error', () => process.exit(1))"

# Start the application
CMD ["npm", "start"]
