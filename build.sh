#!/bin/bash

docker run -v $PWD:/src -it -u 1000:1000 jguyomard/hugo-builder hugo

docker build -t matturbanski/iflowfor8hours.info .

docker run -p 8080:80 -it matturbanski/iflowfor8hours.info
