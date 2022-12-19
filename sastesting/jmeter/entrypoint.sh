#!/bin/sh
/wait-for-it.sh juice_shop:3000 -t 30
/wait-for-it.sh zap:8090 -t 90

echo "Start JMETER SAS Tests against http://juice_shop:3000 through proxy http://zap:8090"
jmeter -n -t /app/unauthApiRequests.jmx

# Zap needs his time for validate some scannerresults and generate reports
sleep 10

echo "Download alertsSummary.json to /app/zapresults"
curl http://zap:8090/JSON/alert/view/alertsSummary/?baseurl=http://juice_shop:3000 > ./zapresults/alertsSummary.json 

echo "Generate sasreport.pdf"
curl "http://zap:8090/JSON/reports/action/generate/?title=JuiceShop&template=traditional-pdf&theme=&description=&contexts=&sites=http://juice_shop:3000&sections=&includedConfidences=&includedRisks=&reportFileName=sasreport&reportFileNamePattern=&reportDir=/home/zap/results&display="