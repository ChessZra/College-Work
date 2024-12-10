#!/bin/bash
# what happens when a directory is requested -> 404

PORT=$@

REQUEST=$'GET /tests/08-files-error-checking HTTP/1.1\r\n\r\n'

for _ in $(seq 1 3); do
    printf "$REQUEST" | nc -N 127.0.0.1 $PORT
done
