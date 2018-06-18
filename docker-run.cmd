set DOCK_NAME=zoomer-pw
set IMAGE_NAME=alxzoomer/zoomer-pw
set CERTBOT_WEBROOT_HOST=D:/Temp
set CERTBOT_WEBROOT_DOCK=/usr/src/app/public/certbot_webroot
set LETS_ENCRYPT_HOST=D:/temp/letsencrypt
set LETS_ENCRYPT_DOCK=/etc/letsencrypt
call docker-stop.cmd
docker run --name %DOCK_NAME% -v %LETS_ENCRYPT_HOST%:%LETS_ENCRYPT_DOCK%:ro -v %CERTBOT_WEBROOT_HOST%:%CERTBOT_WEBROOT_DOCK%:ro -p 8080:8080 -p 8443:8443 -d %IMAGE_NAME%
