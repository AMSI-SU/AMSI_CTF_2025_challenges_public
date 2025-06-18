#!/bin/sh

IMGTAG="pwn-08-ahahah_magic_word_part_1"
IMGNAME="pwn-08-ahahah_magic_word_part_1-image"

# Build the docker image
echo "BUILD docker $IMGTAG"
docker build -t $IMGTAG .

# Kill potential previous docker container
echo "KILL docker $IMGNAME"
docker kill $IMGNAME
docker rm $IMGNAME

# Run the docker container
#   - forward port 4008 on host to 4008 in container
echo "RUN docker tag:$IMGTAG   name:$IMGNAME"
docker run --name $IMGNAME -p 4008:4008 $IMGTAG
