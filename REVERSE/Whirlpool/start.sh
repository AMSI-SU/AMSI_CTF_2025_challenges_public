#!/bin/sh

IMGTAG="rev-00-whirlpool"
IMGNAME="rev-00-whirlpool-image"
PORT=4055

# Build the Docker image
echo "BUILD docker $IMGTAG"
docker build -t $IMGTAG .

# Kill potential previous docker
echo "KILL docker $IMGNAME"
docker kill $IMGNAME 2>/dev/null || true
docker rm $IMGNAME 2>/dev/null || true

# Run the Docker image
# - forward port of the docker $PORT to machine $PORT
echo "RUN docker tag:$IMGTAG   name:$IMGNAME"
docker run --name $IMGNAME -p $PORT:$PORT -d $IMGTAG

echo "Container started on port $PORT"
echo "Connect with: nc localhost $PORT"
