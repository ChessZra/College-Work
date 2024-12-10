#!/bin/bash

# sequence of bad 400 & good echo requests
# MOVE TO ERRORS

PORT=$@

REQUEST1=$'GET /echo HTTP/1.1\r
Header1: Value1\r
Header2: Value2\r
Header3: Value3\r
Header4: Value4\r
Header5: Valu'

REQUEST2=$'GET /echo HTTP/1.1\r
Header1: Value1\r
Header2: Value2\r
Header3: Value3\r\n\r\n'


for _ in {1..3}; do
    printf "$REQUEST1" | nc -N 127.0.0.1 $PORT 2> /dev/null
    printf "\n"
    printf "$REQUEST2" | nc -N 127.0.0.1 $PORT 2> /dev/null
    printf "\n"
done
