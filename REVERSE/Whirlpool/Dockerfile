FROM python:3.11-slim

# Create working directory
WORKDIR /app

# Create non-root user
RUN useradd -m ctfuser

# Copy files and set permissions
COPY server.py .
COPY chal.bin .
COPY flag.txt .
RUN chmod +x chal.bin && chown ctfuser:ctfuser /app/*

# Switch to non-root user
USER ctfuser

# Expose the port
EXPOSE 4055

# Run the server
CMD ["python3", "server.py"]
