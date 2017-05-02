#!/bin/sh
sudo curl -sSL https://get.docker.com/ | sh
docker run --detach --publish 80:8080 drhelius/terraform-azure-bootcamp-2017