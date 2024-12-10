#!/bin/bash
# Generates a random number of random headers and echoes them

PORT=$@
EOL=$'\r\n'

REQUEST="GET /echo HTTP/1.1"
EXPECTED=""

function generate_test ()
{
    REQUEST="GET /echo HTTP/1.1"
    BODY=""

    for _ in $(seq 1 $1); do
        NAME_LEN=$((1 + $RANDOM % 20))
        CONTENT_LEN=$((1 + $RANDOM % 20))

        NAME=`dd if=/dev/urandom count=1 bs=20 2>/dev/null | base64 | head -c $NAME_LEN | sed s/://g`
        CONTENT=`dd if=/dev/urandom count=1 bs=20 2>/dev/null | base64 | head -c $CONTENT_LEN | sed s/://g`

        VAR="$NAME: $CONTENT"
        REQUEST="$REQUEST$EOL$VAR"
        [[ -n $BODY ]] && BODY="$BODY$EOL$VAR" || BODY="$VAR"
    done

    EXPECTED="HTTP/1.1 200 OK${EOL}Content-Length: ${#BODY}${EOL}${EOL}${BODY}"
    REQUEST="${REQUEST}${EOL}${EOL}"
}


for _ in {1..20}; do
    VARS=$((1 + $RANDOM % 20))
    generate_test $VARS
    printf "$REQUEST" | nc -N 127.0.0.1 $PORT >actual
    printf "$EXPECTED" >expected
    diff actual expected
done
