+++
layout = "single"
title = "Building a containerized pipeline for this website"
date = "2016-12-07"
tags = [
  "pipelines",
  "CD",
  "nginx",
  "containers",
  "blogging",
  "docker",
  "letsencrypt"
  ]

+++

If you've been following along, I now have a CoreOS box running on digitalocean, currently doing nothing. I have a locally built container with nginx and my content inside of it.

I get the following output when I run `docker-machine ls`

    NAME                  ACTIVE   DRIVER         STATE     URL                          SWARM   DOCKER    ERRORS
    iflowfor8hours-core   -        digitalocean   Running   tcp://159.203.119.101:2376           v1.11.2   
    
The plan now is to deploy my container manually first, then write a docker-compose file to orchestrate the deployment of the app container and the letsencrypt proxy.



