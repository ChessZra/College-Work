#!/bin/bash

rm read expected &> /dev/null

PORT=$@

SIZE=500
RANDOM_DATA=`dd if=/dev/urandom count=1 bs=1000 status=none | base64 | head -c ${SIZE}`
printf "$RANDOM_DATA" >expected

EOL=$'\r\n'

REQUEST1=$'POST /write HTTP/1.1'${EOL}$'Content-Length: '${SIZE}${EOL}${EOL}${RANDOM_DATA}
REQUEST2=$'GET /read HTTP/1.1'${EOL}${EOL}

printf "$REQUEST1" | nc 127.0.0.1 $PORT >/dev/null 2>&1

curl -s http://127.0.0.1:$PORT/read >actual

diff expected actual
