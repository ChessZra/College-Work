#!/bin/bash

PORT=$@

RANDOM_DATA=`date | md5sum`

EOL=$'\r'

REQUEST1="POST /write HTTP/1.1$EOL
Header1: Value1$EOL
Header2: Value2$EOL
Header3: Value3$EOL
Header4: Value4$EOL
Content-Length: 35$EOL
Header5: Value5$EOL
Header6: Value6$EOL
$EOL
$RANDOM_DATA"

REQUEST2=$'GET /read HTTP/1.1\r\n\r\n'

EXPECTED="HTTP/1.1 200 OK$EOL
Content-Length: 35$EOL
$EOL
$RANDOM_DATA
HTTP/1.1 200 OK$EOL
Content-Length: 35$EOL
$EOL
$RANDOM_DATA"

printf "$EXPECTED" >expected
printf "$REQUEST1" | nc 127.0.0.1 $PORT >actual
printf "\n" >>actual
printf "$REQUEST2" | nc 127.0.0.1 $PORT >>actual

diff expected actual
