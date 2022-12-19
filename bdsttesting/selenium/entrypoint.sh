#!/bin/sh
set -e
/wait-for-it.sh juice_shop:3000 --timeout=30 -- /wait-for-it.sh zap:8090 --timeout=90 -- rspec . || EXIT_CODE=$? 
sleep 5 
curl -X GET http://zap:8090/HTML/core/view/alerts > ./zapresults/bdstreport.HTML
curl -X GET http://zap:8090/JSON/core/view/alerts > ./zapresults/bdstreport.JSON 
exit $EXIT_CODE