#!/bin/bash

PORT=$@

REQUEST=$'GET /tests/07-files/index.html HTTP/1.1\r\n\r\n'

for i in {1..100}; do
    printf "$REQUEST" | nc -N 127.0.0.1 $PORT >/dev/null 2>&1
done
printf "$REQUEST" | nc -N 127.0.0.1 $PORT
