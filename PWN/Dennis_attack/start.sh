#!/bin/sh

IMGTAG="pwn-09-dennis-attack"
IMGNAME="pwn-09-dennis-attack-image"

# Compile binaries
make -C ./spoil/
cp ./spoil/main ./public/main
cp ./spoil/database ./public/database
cp ./spoil/passwords.txt ./public/passwords.txt
cp ./spoil/flag.txt ./public/flag.txt

# Build the docker image
echo "BUILD docker $IMGTAG"
docker build -t $IMGTAG .

# Kill potentiel previous docker
echo "KILL docker $IMGTAG"
docker kill $IMGNAME
docker rm $IMGNAME

# Run the docker image
#   - forward port of the docker 4004 to machine 4004
echo "RUN docker tag:$IMGTAG   name:$IMGNAME"
docker run --cap-drop=ALL --security-opt no-new-privileges:true --name $IMGNAME -p 4004:4004 $IMGTAG &
# sleep 3
# docker exec -it $IMGNAME /bin/bash
