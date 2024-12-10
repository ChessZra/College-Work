#!/bin/bash
# oscillating sizes

PORT=$@

EOL=$'\r\n'

SSIZE=20
SDATA=`printf "%2048s" | tr " " "a" | head -c $SSIZE`

MSIZE=1024
MDATA=`printf "%2048s" | tr " " "b" | head -c $MSIZE`

LSIZE=1700
LDATA=`printf "%2048s" | tr " " "c" | head -c $LSIZE`

REQUEST1=$'POST /write HTTP/1.1'${EOL}$'Content-Length: '${SSIZE}${EOL}${EOL}${SDATA}
REQUEST2=$'POST /write HTTP/1.1'${EOL}$'Content-Length: '${MSIZE}${EOL}${EOL}${MDATA}
REQUEST3=$'POST /write HTTP/1.1'${EOL}$'Content-Length: '${LSIZE}${EOL}${EOL}${LDATA}
REQUEST4=$'GET /read HTTP/1.1'${EOL}${EOL}

for _ in $(seq 1 3); do
    printf "$REQUEST1" | nc -N 127.0.0.1 $PORT
    printf "\n"
    printf "$REQUEST2" | nc -N 127.0.0.1 $PORT
    printf "\n"
    printf "$REQUEST3" | nc -N 127.0.0.1 $PORT
    printf "\n"
    printf "$REQUEST4" | nc -N 127.0.0.1 $PORT
    printf "\n"
done
