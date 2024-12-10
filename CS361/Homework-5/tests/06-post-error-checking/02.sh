#! /bin/bash

# this test: posting more than 1024 bytes of random data

PORT=$@

SIZE=1361
RAND_DATA=`dd if=/dev/urandom bs=$SIZE count=1 status=none | base64 | head -c $SIZE`

EOL=$'\r\n'

REQUEST1=$'POST /write HTTP/1.1\r
Content-Length: '${SIZE}${EOL}${EOL}${RAND_DATA}

REQUEST2=$'GET /read HTTP/1.1'${EOL}${EOL}

printf "$REQUEST1" | nc -N 127.0.0.1 $PORT
printf "\n"
printf "$REQUEST2" | nc -N 127.0.0.1 $PORT
