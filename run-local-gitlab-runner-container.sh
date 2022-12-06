#!/bin/bash
NAME="gitlab-runner1"

docker run -d \
  --name $NAME \
  --restart always \
  -v /$PWD:/app \
  -v //var/run/docker.sock:/var/run/docker.sock \
  -v gitlab-runner-config:/etc/gitlab-runner \
  gitlab/gitlab-runner:latest
echo
docker exec -it -w //app $NAME gitlab-runner exec docker wasttesting