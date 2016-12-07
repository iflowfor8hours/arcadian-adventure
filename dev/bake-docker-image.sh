#!/bin/bash
# Create a production and non-prod BASEURL environment variable in pipeline configuration

if [ -z "${BASEURL}" ]; then 
    HUGO_BASEURL='http://localhost/'
else 
    HUGO_BASEURL=${BASEURL}
fi

env HUGO_BASEURL=${HUGO_BASEURL} hugo --cleanDestinationDir
docker build -t iflowfor8hours:blog .

echo docker run --name bakedblog -p 80:80 iflowfor8hours:blog
