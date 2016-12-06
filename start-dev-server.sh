#!/bin/bash
hugo --cleanDestinationDir --baseURL http://localhost/
sudo chmod -R 777 public
docker stop docker-nginx
docker rm -f docker-nginx
docker run --name docker-nginx -v "$PWD"/public:/usr/share/nginx/html -v "$PWD"/dev/nginx.conf:/etc/nginx/nginx.conf:ro -p 80:80 nginx  
