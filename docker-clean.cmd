set DOCK_NAME=zoomer-pw
set DOCK_IMAGE=alxzoomer/zoomer-pw:latest
docker stop %DOCK_NAME%
docker rm %DOCK_NAME%
docker image rm %DOCK_IMAGE%
