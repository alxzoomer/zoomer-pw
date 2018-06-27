set DOCK_NAME=zoomer-pw
set IMAGE_NAME=alxzoomer/zoomer-pw
set CERTBOT_WEBROOT_HOST=D:/Temp
set CERTBOT_WEBROOT_DOCK=/usr/src/app/public/certbot_webroot
set LETS_ENCRYPT_HOST=D:/temp/letsencrypt
set LETS_ENCRYPT_DOCK=/etc/letsencrypt
set STATIC_RW_DOCK=/usr/src/app/public/static_rw
set STATIC_RW_HOST=D:/Temp/rw
call docker-stop.cmd
docker run --name %DOCK_NAME% -v %LETS_ENCRYPT_HOST%:%LETS_ENCRYPT_DOCK%:ro -v %CERTBOT_WEBROOT_HOST%:%CERTBOT_WEBROOT_DOCK%:ro ^
  -v %STATIC_RW_HOST%:%STATIC_RW_DOCK% -p 8080:8080 -p 8443:8443 -d %IMAGE_NAME%
