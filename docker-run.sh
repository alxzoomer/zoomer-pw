#!/bin/sh

DOCK_NAME="zoomer-pw"
IMAGE_NAME="alxzoomer/zoomer-pw"
CERTBOT_WEBROOT_HOST=/var/www
CERTBOT_WEBROOT_DOCK=/usr/src/app/public/certbot_webroot

. ./docker-stop.sh
docker rm $DOCK_NAME
docker run --rm --name $DOCK_NAME -v $CERTBOT_WEBROOT_HOST:$CERTBOT_WEBROOT_DOCK:ro -p 8080:8080 -p 8443:8443 -d $IMAGE_NAME
