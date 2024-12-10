#! /bin/bash
# null byte in the data
#POST /write followed by GET /read

PORT=$@

RSIZE=$((10 + $RANDOM % 50))
EOL=$'\r\n'
DATA1=`dd if=/dev/urandom bs=$RSIZE count=1 status=none| base64 | head -c $RSIZE`$'There is a mysterious and secret byte right here'
DATA2=$'this data is part of the post'`dd if=/dev/urandom bs=$RSIZE count=1 status=none | base64 | head -c $RSIZE`
SIZE=$((${#DATA1} + ${#DATA2} + 1))

REQUEST1=$'POST /write HTTP/1.1\r
Content-Length: '${SIZE}${EOL}${EOL}
REQUEST2=$'GET /read HTTP/1.1'${EOL}${EOL}
RESPONSE=$'HTTP/1.1 200 OK'${EOL}$'Content-Length: '${SIZE}${EOL}${EOL}

echo -n -e "${REQUEST1}${DATA1}\x00${DATA2}" | nc 127.0.0.1 $PORT >actual
echo -n -e "${RESPONSE}${DATA1}\x00${DATA2}" >expected
printf "\n" >>actual
printf "\n" >>expected

printf "$REQUEST2" | nc 127.0.0.1 $PORT >>actual
echo -n -e "${RESPONSE}${DATA1}\x00${DATA2}" >>expected
diff expected actual
