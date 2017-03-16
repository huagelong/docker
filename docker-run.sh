#!/bin/sh
docker run --name $1 -v $PWD/www/$1:/data/www -v $PWD/nginx/sites-enabled:/etc/nginx/sites-enabled -p $2:8888 --env test:wkh  trensy:docker