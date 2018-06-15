#!/bin/sh

DOCKER_REPO="alxzoomer"
DOCK_NAME="zoomer-pw"
TAG="latest"

docker push $DOCKER_REPO/$DOCK_NAME:$TAG
