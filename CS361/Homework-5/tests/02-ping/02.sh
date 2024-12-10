#!/bin/bash

PORT=$@

EOL=$'\r\n'
REQUEST=$'GET /ping HTTP/1.1'${EOL}${EOL}

for i in $(seq 1 201); do
    printf "$REQUEST" | nc -N 127.0.0.1 $PORT
done
