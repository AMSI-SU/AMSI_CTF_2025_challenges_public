#!/bin/sh

IMGTAG="web-00-mathml-xss"
IMGNAME="web-00-mathml-xss-image"
PORT=4012

# Build the docker image
echo "BUILD docker $IMGTAG"
docker build -t $IMGTAG .

# Kill potential previous docker
echo "KILL docker $IMGNAME"
docker kill $IMGNAME 2>/dev/null || true
docker rm $IMGNAME 2>/dev/null || true

# Run the docker image
echo "RUN docker tag:$IMGTAG name:$IMGNAME"
docker run --name $IMGNAME -p $PORT:$PORT -d $IMGTAG

echo "✅ Challenge running at: http://localhost:$PORT"
