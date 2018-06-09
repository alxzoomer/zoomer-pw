set DOCK_NAME=zoomer-pw
set IMAGE_NAME=alxzoomer/zoomer-pw
call docker-stop.cmd
docker rm %DOCK_NAME%
docker run --name %DOCK_NAME% -p 8080:8080 -d %IMAGE_NAME%
