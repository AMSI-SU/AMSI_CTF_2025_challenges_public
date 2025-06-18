#!/bin/bash
# Build and run the Flask Password Reset Challenge Docker container

set -e

IMG_TAG="web-04-reset-me"
IMG_NAME="web-04-reset-me-image"
PORT=4050

# Challenge secrets & flag
RESET_SECRET="ultra_secret_reset_key"
FLAG="CTF{example_flag_password_reset}"
DEFAULT_USERS='{"admin":{"password":"adminpass","is_admin":true},"user":{"password":"userpass","is_admin":false}}'

echo "🔨 Building Docker image: $IMG_TAG..."
docker build -t $IMG_TAG \
  --build-arg RESET_SECRET="$RESET_SECRET" \
  --build-arg FLAG="$FLAG" \
  --build-arg DEFAULT_USERS="$DEFAULT_USERS" \
  .

echo "🗑️  Cleaning up old Docker container (if any)..."
docker kill $IMG_NAME 2>/dev/null || true
docker rm $IMG_NAME 2>/dev/null || true

echo "🚀 Starting Docker container..."
docker run --name $IMG_NAME -p $PORT:4050 -d $IMG_TAG

echo "✅ Challenge running at: http://localhost:$PORT"
echo ""
echo "📋 Useful commands:"
echo "  View logs: docker logs -f $IMG_NAME"
echo "  Stop:     docker kill $IMG_NAME && docker rm $IMG_NAME"
