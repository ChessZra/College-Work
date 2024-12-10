#! /bin/bash

# this test: posting more than 1024 bytes of random data
# but lying about it! this should lead to data truncation

PORT=$@

SIZE=1361
RAND_DATA=`dd if=/dev/urandom bs=$SIZE count=1 2>/dev/null | base64 | head -c $SIZE`

EOL=$'\r\n'
REQUEST1=$'POST /write HTTP/1.1\r
Content-Length: 500'${EOL}${EOL}${RAND_DATA}

REQUEST2=$'GET /read HTTP/1.1'${EOL}${EOL}

RESPONSE=$'HTTP/1.1 200 OK'${EOL}$'Content-Length: 500'${EOL}${EOL}

printf "$REQUEST1" | nc -N 127.0.0.1 $PORT >actual
printf "\n" >>actual
printf "$REQUEST2" | nc -N 127.0.0.1 $PORT >>actual

REAL_DATA=`printf "$RAND_DATA" | head -c 500`

printf "${RESPONSE}${REAL_DATA}" >expected
printf "\n" >>expected
printf "${RESPONSE}${REAL_DATA}" >>expected

diff actual expected
