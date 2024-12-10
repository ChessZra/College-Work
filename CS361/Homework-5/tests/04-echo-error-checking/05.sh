#! /bin/bash
# this test: echo data is at max

PORT=$@

EOL=$'\r\n'
REQUEST=$'GET /echo HTTP/1.1'${EOL}$'Header1: '`printf "%1015s" | tr " " "C"`${EOL}${EOL}

printf "$REQUEST" | nc -N 127.0.0.1 $PORT 2>/dev/null
