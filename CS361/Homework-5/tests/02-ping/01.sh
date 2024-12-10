#!/bin/bash

PORT=$@

EOL=$'\r\n'
REQUEST=$'GET /ping HTTP/1.1'${EOL}${EOL}

printf "$REQUEST" | nc 127.0.0.1 $PORT
