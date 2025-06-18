#!/bin/sh

IMGTAG="misc-02-sshd-challenge"
IMGNAME="misc-02-sshd-challenge-image"
PORT=4003

# Build the docker image
echo "BUILD docker $IMGTAG"
docker build -t $IMGTAG .

# Kill potential previous docker container
echo "KILL docker $IMGNAME"
docker kill $IMGNAME 2>/dev/null || true
docker rm $IMGNAME 2>/dev/null || true

# Run the docker image and forward port 4003
echo "RUN docker tag:$IMGTAG name:$IMGNAME"
docker run --name $IMGNAME -p $PORT:$PORT -d $IMGTAG

echo "Container started on port $PORT"
echo "Connect with: ssh -p $PORT ctf@localhost (password: ctf)"
