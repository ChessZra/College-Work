#!/bin/bash

PORT=$@

RANDOM_DATA=`dd if=/dev/urandom count=5 bs=1024 status=none | base64`
printf "$RANDOM_DATA" >expected
printf "$RANDOM_DATA" >file

curl -s http://127.0.0.1:$PORT/file >actual 2>&1
diff expected actual
