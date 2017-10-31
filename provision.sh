#!/bin/sh
# install docker
sudo curl -sSL https://get.docker.com/ | sh
# run dummy service that returns host id and load info
docker run --detach --publish 80:3000 sbehrends/docker-node-echo-hostname