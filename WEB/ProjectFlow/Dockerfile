FROM python:3.10-slim

# Create a non-root user
RUN adduser --disabled-password --gecos "" appuser

WORKDIR /ctf

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source and flag
COPY . .

# Change ownership to the non-root user
RUN chown -R appuser:appuser /ctf

# Switch to the non-root user
USER appuser

# Expose the port
EXPOSE 4016

# Start Gunicorn using app factory syntax
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:4016", "app:create_app()"]
