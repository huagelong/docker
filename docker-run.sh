#!/bin/sh
docker run --name trensy -v $PWD:/data -p 8888:8888 -d trensy:docker