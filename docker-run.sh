#!/bin/sh

DOCK_NAME="zoomer-pw"
IMAGE_NAME="alxzoomer/zoomer-pw"

. ./docker-stop.sh
docker rm $DOCK_NAME
docker run --rm --name $DOCK_NAME -p 8080:8080 -d $IMAGE_NAME
