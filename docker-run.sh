#!/bin/sh
docker run --name trensy -v $PWD/www:/data/www/ -p 8888:8888 -d trensy:docker