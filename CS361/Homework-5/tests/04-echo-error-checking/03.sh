#!/bin/bash

# body of the response for echo would be too large
# request should be 413

PORT=$@

EOL=$'\r\n'
REQUEST=$'GET /echo HTTP/1.1'${EOL}$'Header1: '`printf "%1070s" | tr " " "U"`${EOL}${EOL}

printf "$REQUEST" | nc -N 127.0.0.1 $PORT 2>/dev/null
