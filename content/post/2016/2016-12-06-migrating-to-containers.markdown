+++
layout = "single"
title = "Migrating From a Static Ubuntu to Containerized Infrastructure"
date = "2016-12-07"
tags = [
  "pipelines",
  "CD",
  "nginx",
  "containers",
  "blogging",
  "docker"
  ]

+++

The time has come to move off my statically hosted ubuntu box on Digital Ocean and on to a more modern and containerized stack. 

_Why?_

My Digital Ocean box was 32-bit Ubuntu, and I had not done much in terms of maintaining it in a while. I considered upgrading it, but the configuration was a _work of art_ and my work with CoreOS and containers in my dayjob inspired me to move to something more modern. I didn't want to go the Ansible plus static infrastructure route, since I have been migrating clients off that for a few years now. I wanted to run a few other applications in containers as well so I thought this would be a good starting point. I have done this type of work frequently for entire enterprises, so this was the obvious choice. I'm documenting it because it was a fun exercise and others might benefit from it. Here is the existing infrastructure and pipeline:

Github -> Codeship Pipeline to hugo build, smoke test, then rsync artifacts -> Digital Ocean box with NGINX and Let's Encrypt SSL

Simple setup. I didn't really like the rsync in the pipeline, or NGINX being non-configuration managed, but it worked and was comfortable.

Here is the desired state:

Github push -> something Hugo build -> something Container packaging -> Ship to containerized host -> Decomission previous nginx container.

I also wanted to put let's encrypt into its own container for bonus points, and so that I could run the same artifact locally and remotely.

I got started by doing a basic local nginx container that mounted my generated hugo source by mounting it. This is for my quick iterative development workflow.

      #!/bin/bash
      hugo --cleanDestinationDir --baseURL http://localhost/
      chmod -R 777 public
      docker stop iflowfor8hours-nginx-sidecar
      docker rm -f iflowfor8hours-nginx-sidecar
      docker run --name iflowfor8hours-nginx-sidecar -v "$PWD"/public:/usr/share/nginx/html -v "$PWD"/dev/nginx.conf:/etc/nginx/nginx.conf:ro -p 80:80 nginx:alpine

The `chmod -R 777` is ugly, but I'm not concerned with anything getting broken since this is generated code and only used locally.

The next phase involved creating the container that I would use in production. I didn't want to bake the let's encrypt stuff into the container because I felt that it violated the concept of small, single purpose containers. I wrote a minimal `Dockerfile` first and built it by hand. 

    FROM nginx:alpine
    COPY public /usr/share/nginx/html
    RUN chown -R nginx:nginx /usr/share/nginx/html
    COPY dev/nginx.conf /etc/nginx/nginx.conf

I'm using nginx:alpine because I was considering using [hyper.sh](https://hyper.sh) to host my containers, and still might. I wanted to keep it as small as possible since this is only going to be serving static html. This was another reason for the added complexity cost of putting let's encrypt in another container.

I then wrote the script for building the content and the container. I figured I might as well do this now, as the CI system will need some kind of entrypoint. This also helped me iterate quickly on my local box. 

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

I played with that for a bit, and everything works as expected. Now I need to get lets encrypt working. Since certs are free and I already own my domain, I can afford to have an https enabled staging environment. I now needed to decide on a docker hosting environment and platform. The easiest way to get up and running with containerized infrastructure is CoreOS, hands down. I spun up a coreos box on DO and then reconfigured my DNS to point it at.

The next phase will be to setup the pipeline and finally deploy my containers to the newly provisioned container host.

I also plan on migrating to IPv6 when the hosts are setup properly.
