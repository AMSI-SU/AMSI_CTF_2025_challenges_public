FROM php:8.2-cli

# Set working directory
WORKDIR /var/www/html

# Copy challenge files
COPY . /var/www/html

# Install required PHP extensions (add here if necessary)
# RUN docker-php-ext-install ...

# Create non-root user for security
RUN addgroup --gid 1001 ctfgroup && \
    adduser --disabled-password --gecos "" --uid 1001 --gid 1001 ctfuser && \
    chown -R ctfuser:ctfgroup /var/www/html

# Switch to non-root user
USER ctfuser

# Expose port
EXPOSE 4014

# Start PHP built-in server
CMD ["php", "-S", "0.0.0.0:4014", "index.php"]
