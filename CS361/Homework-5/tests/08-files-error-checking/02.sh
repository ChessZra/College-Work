#!/bin/bash
# file does not exist -> 404

PORT=$@

REQUEST=$'GET /tests/doesNotExist/index.html HTTP/1.1\r\n\r\n'

for _ in $(seq 1 3); do
    printf "$REQUEST" | nc 127.0.0.1 $PORT
done
