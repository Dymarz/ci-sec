#!/bin/sh
set -e
echo "***** SeleniumBase Docker Machine *****"
echo "Checking for ZAP"
./wait-for-it.sh -c 'nc -z zap 8090' -t 60
echo "Checking for WebGoat"
./wait-for-it.sh -c 'nc -z webgoat 8080' -t 60

# we actually have to run two selenium tests first one to register a user
echo "$@"
echo "running tests"
$@

# create directories to store results in
mkdir -p /results/zap/html
mkdir -p /results/zap/json

# sleep for 10 seconds & then get results form ZAP
sleep 10
curl -X GET http://zap:8090/HTML/core/view/alerts > /results/zap/html/results.HTML
curl -X GET http://zap:8090/JSON/core/view/alerts > /results/zap/json/results.JSON

echo "terminating ZAP"
# tests are done, so terminate ZAP & webgoat
curl -X GET http://zap:8090/JSON/core/action/shutdown/
echo "terminating webgoat"
docker kill  bdsttesting_webgoat_1 --signal=SIGINT
