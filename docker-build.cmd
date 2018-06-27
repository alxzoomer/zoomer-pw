set IMAGE_NAME=alxzoomer/zoomer-pw:latest
docker image rm %IMAGE_NAME% -f
docker build -t %IMAGE_NAME% .
