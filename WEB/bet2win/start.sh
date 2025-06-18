#!/bin/bash

set -e

CHALL_NAME="web-bet2win"
IMAGE_NAME="${CHALL_NAME}"
CONTAINER_NAME="${CHALL_NAME}-container"
PORT=4015

echo "📦 Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

echo "🗑️ Removing previous container if it exists: $CONTAINER_NAME"
docker kill $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo "🚀 Running container: $CONTAINER_NAME"
docker run --name $CONTAINER_NAME -p $PORT:$PORT -d $IMAGE_NAME

echo "✅ Challenge running at: http://localhost:$PORT"
