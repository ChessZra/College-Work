#!/bin/bash
# file does not exist -> 404

PORT=$@

REQUEST=$'GET /tests/doesNotExist/index.html HTTP/1.1\r\n\r\n'

printf "$REQUEST" | nc 127.0.0.1 $PORT
