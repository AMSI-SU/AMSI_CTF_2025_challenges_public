#!/bin/bash
# Build and run the CTF challenge using Docker Compose
set -e

echo "🏗️  Building MathML XSS CTF Challenge..."

# Stop and remove existing containers
docker-compose down --remove-orphans 2>/dev/null || true

# Build and start the container
docker-compose up --build -d

echo "✅ CTF Challenge is now running!"
echo "🌐 Access the challenge at: http://localhost:3000"
echo "🗨️  Forum available at: http://localhost:3000/forum"

# Show container logs
echo "📋 Container logs:"
docker-compose logs

echo ""
echo "🔧 Useful commands:"
echo "  View logs: docker-compose logs -f"
echo "  Stop: docker-compose down"
echo "  Restart: docker-compose restart"
echo "  Rebuild: docker-compose up --build"
