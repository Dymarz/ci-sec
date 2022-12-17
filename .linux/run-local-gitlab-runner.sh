#!/bin/sh


#linux
cd ..

docker run \
    --entrypoint bash \
    --rm \
    -w $PWD \
    -v $PWD:$PWD \
    -v /var/run/docker.sock:/var/run/docker.sock \
    gitlab/gitlab-runner:latest \
    -c 'git config --global --add safe.directory "*"; gitlab-runner exec docker --docker-privileged wasttesting'
