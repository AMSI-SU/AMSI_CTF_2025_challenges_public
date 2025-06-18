#!/bin/sh

IMGTAG="crypto-00-hashcore"
IMGNAME="crypto-00-hashcore-image"

# Build the docker image
echo "BUILD docker $IMGTAG"
docker build -t $IMGTAG .

# Kill potentiel previous docker
echo "KILL docker $IMGTAG"
docker kill $IMGNAME
docker rm $IMGNAME

# Run the docker image
#   - forward port of the docker 4002 to machine 4002
echo "RUN docker tag:$IMGTAG   name:$IMGNAME"
docker run --name $IMGNAME -p 4000:4000 $IMGTAG
