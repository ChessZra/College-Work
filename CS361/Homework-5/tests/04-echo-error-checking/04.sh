#!/bin/bash

# sequence of 413 & good echo requests

PORT=$@

EOL=$'\r\n'
REQUEST1=$'GET /echo HTTP/1.1'${EOL}$'Header1: '`printf "%1070s" | tr " " "U"`${EOL}${EOL}

REQUEST2=$'GET /echo HTTP/1.1\r
Header1: Value1\r
Header2: Value2\r
Header3: Value3\r\n\r\n'


for _ in $(seq 1 3); do
    printf "$REQUEST1" | nc -N 127.0.0.1 $PORT 2> /dev/null
    printf "\n"
    printf "$REQUEST2" | nc -N 127.0.0.1 $PORT 2> /dev/null
    printf "\n"
done
