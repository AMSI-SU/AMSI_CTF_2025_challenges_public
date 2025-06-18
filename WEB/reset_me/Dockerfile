FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install required packages
RUN pip install flask

# Copy application code
COPY app/ /app

# Declare build arguments and set as environment variables
ARG RESET_SECRET
ARG FLAG
ARG DEFAULT_USERS

ENV RESET_SECRET=${RESET_SECRET} \
    FLAG=${FLAG} \
    DEFAULT_USERS=${DEFAULT_USERS}

# Expose port for Flask app
EXPOSE 4050

# Run the application
CMD ["python", "app.py"]
